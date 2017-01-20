require "logger"
require "faraday"
require "alexa/todoist_api/configuration"

module Alexa
  module TodoistApi
    class Base
      include Alexa::TodoistApi::Configuration

      class UnsuccessfulResponseError < StandardError; end
      class MethodNotImplemented < StandardError; end

      def connection()
        headers = append_auth_headers(headers: custom_headers)
        Faraday.new url: api_endpoint, headers: headers
      end

      def connection_requires_auth?
        false
      end

      def custom_headers
        logger_warn('Todoist::BaseApi custom_headers() method not implemented.')
        raise MethodNotImplemented
      end

      def method_route
        '/API/v7/sync'
      end

      def method_params
        logger_warn('Todoist::BaseApi method_params() method not implemented.')
        raise MethodNotImplemented
      end

      def response_success(response:)
        logger_warn("Todoist::BaseApi response_success(response: #{response}) method not implemented.")
        raise MethodNotImplemented
      end

      def response_fail(response:)
        logger_warn("Todoist::BaseApi response_fail(response: #{response}) method not implemented.")
        raise MethodNotImplemented
      end

      def get_route(url:)
        url.sub(api_endpoint, '')
      end

      def do_request
        @connection = connection
        retries ||= 0
        response = @connection.post method_route, method_params
        if response.status == 200
          response_success(response: response)
        else
          logger_warn("[Todoist::BaseApi] Route: #{method_route} Response code: #{response.status} Response body: #{response.body}")
          response_fail(response: response)
        end
      rescue Faraday::TimeoutError
        logger_warn("[Todoist::BaseApi] Route: #{method_route} Retrying...") && retry if (retries += 1) < 2
      rescue Faraday::ClientError => e
        logger_warn("[Todoist::BaseApi] Route: #{method_route}, Error: #{e.class}, #{e.message}")
      end

      private

      def append_auth_headers(headers: {})
        default_headers = {}
        headers.merge(default_headers)
      end

      def logger_warn(message)
        logger = Logger.new(STDOUT)
        logger.level = Logger::WARN
        logger.warn(message)
      end
    end
  end
end
