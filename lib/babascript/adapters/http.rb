module Babascript
  module Adapter
    class HttpAdapter
      def initialize(hostname)
        @hostname = hostname
        @client = Faraday.new(:url => hostname) do |f|
          f.repsonse :logger
          f.adapter Faraday.default_adapter
        end
        @waiting_messages = {}
      end

      def send(message, options={})
        id = message.id
        @waiting_messages[id] = message
      end

      def cancel(message)
        @client.delete "/#{message.id}"
        @waiting_messages[mesage.id] = nil
      end

      def request_result
        return if @waiting_messages.size == 0
        @waiting_messages.each do |message|
          response = @client.get "/#{message.id}"
          if response.status == 200
            # ここで、結果処理をする
            message.
          end
        end
      end

      def request_event(name)
        response = @client.get "/users/#{name}/events"

      end
    end
  end
end
