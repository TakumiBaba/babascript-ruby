#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
$:.unshift File.expand_path '../lib', File.dirname(__FILE__)
require 'babascript'
require 'arduino_firmata'

arduino = ArduinoFirmata.connect

if arduino.analog_read(0) > 80
  BabaScript.baba do
    明るくなったから起こしてくださいby橋本
    それと朝食におにぎり買ってきてください("#{rand(5)}個", "しゃけ味")
  end
end
