# -*- coding: utf-8 -*-
$:.unshift File.expand_path "../lib", File.dirname(__FILE__)
require 'babascript'

EM::run do
  BabaScript.baba do
    count = 0

    電気を消してください do |result|
      puts result
      count += 1
    end

    冷房を切ってください do |result|
      puts result
      count += 1
    end

    机の上を片付けてください do |result|
      puts result
      count += 1
    end

    EM::add_periodic_timer 1 do
      if count < 3
        puts "waiting 3 tasks (#{count} finished)"
      else
        EM::stop
      end
    end
  end
end

puts "finish"
