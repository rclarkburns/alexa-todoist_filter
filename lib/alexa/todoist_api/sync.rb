require "alexa/todoist_api/base"

module Alexa
  module TodoistApi
    class Sync < Base
      attr_accessor :request_params

      def custom_headers
        {}
      end

      def method_params
        validate_request_params
        {
            token: request_params[:api_token],
            sync_token: '*',
            resource_types: '["projects", "items", "labels"]'
        }
      end

      def response_success(response:)
        {
            error: false,
            message: response.body
        }
      end

      def response_fail(response:)
        {
            error: true,
            message: response.body
        }
      end

      private

      def validate_request_params
        true
      end
    end
  end
end
