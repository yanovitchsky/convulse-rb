require 'json'
require 'httparty'
require 'lru_redux'
require 'singleton'
require "convulse/version"
require "convulse/cache"
require "convulse/configuration"
require "convulse/discoverer"

module Convulse
  # Your code goes here...

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.discover(service)
    Discoverer.new.fetch_service(service)
  end
end
