#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
$:.unshift File.expand_path '../lib', File.dirname(__FILE__)
require 'babascript'

BabaScript.run do
  if Time.now.hour < 12
    そろそろ起きたほうがいいのでは？
  else
    アイス買ってきてよ("#{rand(10)}本")
  end
end
