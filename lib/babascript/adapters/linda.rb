require 'rubygems'
require 'linda-socket.io-client'

module Babascript
  module Adapter
    class LindaAdapter
      def initialzie(url)
        @client = Linda::SocketIO::Client.connect url
      end

      def send(task)
        return if !task

        spacename = task.to
        @client.tuplespace(spacename).write task
        return task.id
      end

      def wait(task, &block)
        return unless block_given?

        spacename = task.to
        id = task.id
        @client.tuplespace(spacename).take id: id do |err, tuple|
          block.call err ? err : tuple if block_given?
        end
      end

      def cancel(spacename, id)
        @client.tuplespace(spacename).cancel id
      end
    end
  end
end
