module BabaScript
  def self.baba(&block)
    self::Baba.run(&block)
  end

  class Baba

    def self.linda
      @@linda ||= EM::RocketIO::Linda::Client.new BabaScript.LINDA_BASE
    end

    def self.run(block_or_code)
      raise ArgumentError "block or code require" unless [Proc, String].include? block_or_code.class
      EM::run do
        linda.io.on :connect do
          EM::defer do
            ::BabaScript::Baba.instance_eval block_or_code
          end
        end
      end
    end

    def self.method_missing(name, *args)
      cid = __create_callback_id
      tuple = [:babascript, :eval, name, args, {:callback => cid}]
      ts = linda.tuplespace[BabaScript.LINDA_SPACE]
      ts.write tuple
      result = ts.take [:babascript, :return, cid]
      return result[3]
    end

    private
    def self.__create_callback_id
      Digest::MD5.hexdigest "#{Time.now.to_i}_#{Time.now.usec}_#{rand 100000}"
    end
  end
end
