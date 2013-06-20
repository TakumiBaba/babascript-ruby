require "babascript/version"
require "babascript/baba"
require "httparty"
require "json"

module BabaScript
  def self.LINDA_BASE
    ENV["LINDA_BASE"] || "http://linda.masuilab.org"
  end

  def self.LINDA_SPACE
    ENV["BABA"] || "takumibaba"
  end
end
