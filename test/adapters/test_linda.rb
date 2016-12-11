# -*- coding: utf-8 -*-
require File.expand_path 'test_helper', File.dirname(__FILE__)

require 'linda-sockt.io-client'

class TestLindaAdapter < MiniTest::Test

  def test_send_task
    linda_url = 'https://babascript-linda-server.heroku.com'
    adapter = Babascript::Adapter::LindaAdapter.new linda_url
    c = Linda::SocketIO::Client.new linda_url

    task = Babascript::Task.new 'test_name','test_todo'
    adapter.send task
    c.take
  end

  def test_receive_task
  end

  def test_cancel_task
  end

  def test_error_task
  end
end
