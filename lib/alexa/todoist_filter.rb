require "alexa/todoist_filter/version"
require "alexa/todoist_api/sync"
require "alexa/todoist_api/item_move"
require "thor"
require "json"

module Alexa
  module TodoistFilter
    class CLI < Thor
      desc "inbox_todos API_TOKEN PROJECT_NAME", "Check Inbox for items with 'Alexa' label and move to PROJECT_NAME"
      def inbox_todos(api_token, project_name)
        @api_token = api_token
        @project_name = project_name
        todoist_response = todoist_api_sync
        project_ids = project_ids(todoist_response['projects'])
        alexa_label_id = label_id(todoist_response['labels'])
        if alexa_label_id.nil?
          puts "Label 'Alexa' not found in account."
          exit 1
        end
        inbox_items = item_ids(todoist_response['items'], project_ids[:inbox], alexa_label_id)
        if inbox_items.empty?
          puts "No Alexa todos found in the inbox."
          exit 1
        end
        todoist_api_item_move(inbox_items, project_ids)
      end

      private

      def todoist_api_sync
        sync = Alexa::TodoistApi::Sync.new
        sync.request_params = {
            api_token: @api_token
        }
        response = sync.do_request
        response = response.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
        if response[:error]
          puts "Halting due to error response. #{response[:message]}"
          exit 1
        end
        JSON.parse(response[:message])
      end

      def todoist_api_item_move(inbox_items, project_ids)
        item_move = Alexa::TodoistApi::ItemMove.new
        item_move.request_params = {
            api_token: @api_token,
            project_items: {},
            new_project: project_ids[@project_name.to_sym]
        }
        item_move.request_params[:project_items][project_ids[:inbox].to_s.to_sym] = inbox_items
        item_move.do_request
      end

      def project_ids(projects)
        pids = {inbox: nil}
        pids[@project_name.to_sym] = nil
        projects.each do |project|
          pids[:inbox] = project['id'] if project['name'].downcase == 'inbox'
          pids[@project_name.to_sym] = project['id'] if project['name'].downcase == @project_name.downcase
        end
        pids
      end

      def label_id(labels)
        labels.each do |label|
          return label['id'] if label['name'].downcase == 'alexa'
        end
        nil
      end

      def item_ids(items, project_id, label_id)
        item_ids = []
        items.each do |item|
          item_ids << item['id'] if item['project_id'] == project_id && item['labels'].include?(label_id)
        end
        item_ids
      end

    end
  end
end
