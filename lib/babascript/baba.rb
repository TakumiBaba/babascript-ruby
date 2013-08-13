module BabaScript
  def self.baba(&block)
    self::Baba.run &block if block_given?
  end

  class Baba

    def self.linda
      @@linda ||= EM::RocketIO::Linda::Client.new BabaScript.LINDA_BASE
    end

    def self.run(code=nil, &block)
      raise ArgumentError "block or code require" unless block_given? or code.kind_of? String
      already_eventmachine_running = EM::reactor_running?
      EM::run do
        linda.io.once :connect do
          EM::defer do
            if block_given?
              ::BabaScript::Baba.instance_eval &block
            else
              ::BabaScript::Baba.instance_eval code
            end
            unless already_eventmachine_running
              EM::add_timer 1 do
                EM::stop
              end
            end
          end
        end
      end
    end

    def self.method_missing(name, *args, &block)
      cid = __create_callback_id
      tuple = [:babascript, :eval, name, args, {:callback => cid}]
      ts = linda.tuplespace[BabaScript.LINDA_SPACE]
      ts.write tuple
      if block_given?
        ts.take [:babascript, :return, cid] do |result|
          next if result.size < 4
          block.call result[3]
        end
      else
        result = ts.take [:babascript, :return, cid]
        return result[3]
      end
    end

    private
    def self.__create_callback_id
      Digest::MD5.hexdigest "#{Time.now.to_i}_#{Time.now.usec}_#{rand 100000}"
    end
  end
end
