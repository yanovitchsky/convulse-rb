require 'json'
require 'httparty'
require 'lru_redux'
require 'singleton'
require "convulse/version"
require "convulse/cache"
require "convulse/discoverer"

module Convulse
  # Your code goes here...

  def self.discover(service)
    Discoverer.new.fetch_service(service)
  end
end
