module BabaScript
  def self.baba(&block)
    self::Baba.run(&block)
  end

  class Baba
    def self.run(&block)
      self.instance_eval &block if block_given?
    end

    def self.method_missing(name, *args)
      tuple = ["notifications", name]
      tuple.push args unless args.empty?
      query = {
        :body => {:tuple => tuple.to_json}
      }
      puts "#{BabaScript.LINDA_BASE}/#{BabaScript.LINDA_SPACE}.write"
      HTTParty.post("#{BabaScript.LINDA_BASE}/#{BabaScript.LINDA_SPACE}.write", query)
    end
  end
end
