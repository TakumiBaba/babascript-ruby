module BabaScript
  def self.run(&block)
    self.instance_eval &block if block_given?
  end

  def self.method_missing(name, *args)
    tuple = ["notifications", name]
    tuple.push args unless args.empty?
    query = {
      :body => {:tuple => tuple.to_json}
    }
    HTTParty.post("#{LINDA_BASE}/#{LINDA_SPACE}.write", query)
  end
end
