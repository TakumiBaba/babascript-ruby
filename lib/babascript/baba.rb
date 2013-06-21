module BabaScript
  def self.baba(&block)
    self::Baba.run(&block)
  end

  class Baba
    def self.run(&block)
      self.instance_eval &block if block_given?
    end

    def self.method_missing(name, *args)
      puts name
      tuple = ["notifications", name, {:callback => __create_callback_id}]
      tuple.push args unless args.empty?
      query = {
        :body => {:tuple => tuple.to_json}
      }
      HTTParty.post("#{BabaScript.LINDA_BASE}/#{BabaScript.LINDA_SPACE}.write", query)
    end

    private
    def self.__create_callback_id
      Digest::MD5.hexdigest "#{Time.now.to_i}_#{Time.now.usec}_#{rand 100000}"
    end
  end
end
