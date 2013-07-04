#!/usr/bin/env baba
# -*- coding: utf-8 -*-

res = かず助に行きたい人の出欠取ってください
puts res # => "6人です"
loop do
  num = res.to_i
  if num > 0
    では予約してください("#{num}人")
    exit
  else
    res = 残念・・その次の週はどうですか？
    puts res
  end
end
