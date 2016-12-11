require 'concurrent-edge'

class BB
  def method_missing(name, *args, &block)
    channel = Concurrent::Channel.new
    Concurrent::Channel.go do
      if block_given?
        block.call 'block_given'
        channel.put 'hello'
      else
        channel.put 'block_not_given'
      end
    end
    unless block_given?
      result = channel.take
      channel.close
      puts result
      return result, name
    end
  end
end

b = BB.new

# b.hoge

# def b(name, &block)
#   block.call
# end

# puts b.b

b.a do |a|
  puts a
end
puts 'hello'
