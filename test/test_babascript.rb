# -*- coding: utf-8 -*-
require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestBabaScript < MiniTest::Test

  ENV["BABA"] = "test"

  def test_eval_write_tuple
    tuple_ = nil
    EM::run do
      linda = EM::RocketIO::Linda::Client.new BabaScript.LINDA_BASE
      ts = linda.tuplespace[ BabaScript.LINDA_SPACE ]
      linda.io.once :connect do
        ts.take [:babascript, :eval] do |tuple|
          tuple_ = tuple
          EM::add_timer 1 do
            EM::stop
          end
        end
      end

      BabaScript.baba do
        テスト 1, 2, "かずすけ"
      end
    end

    assert_equal tuple_.class, Array
    assert_equal tuple_.size, 5
    assert_equal tuple_[0], "babascript"
    assert_equal tuple_[1], "eval"
    assert_equal tuple_[2], "テスト"
    assert_equal tuple_[3], [1, 2, "かずすけ"]
    assert_equal tuple_[4].class, Hash
    assert tuple_[4].has_key? "callback"
  end

end
