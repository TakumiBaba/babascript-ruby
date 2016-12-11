require 'concurrent'

module BabaScript
  def self.baba(&block)
    return unless block_given?

    name = ENV['BABA']
    Babascript::Baba.new(name).run do
      yield
    end
  end
  class Baba
    def initialize(name, client)
      @name = name
      @client = client || Babascript::Adapter::Linda.new
      @plugins = Babascript::Plugin::PluginManager.new
    end

    def run(code=nil, &block)
      if block_given?
        self.instance_eval block
      else
        exec(code)
      end
    end

    def method_missing(name, *args, &block)

    end

    def exec(body, params, &block)
      timestamp = Time.now.to_i
      params[:cid] = cid
      params[:timestamp] = timestamp
      data = Babascript::Message.new(@name, body, params)
      id = @client.send @name, data
      if block_given?
        @client.wait @name, id do |err, data|
          block.call err ? err : data
        end
      else
        channel = Concurrent::Channel.new
        Concurrent::Channel.go do
          @client.wait @name, id do |err, data|
            channel.put err ? err : data
          end
        end
        result = channel.take
        return result
      end
    end
  end
end
