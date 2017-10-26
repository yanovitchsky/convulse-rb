module Convulse
  class Configuration
    attr_accessor :cache_ttl, :cache_size, :consul_uri

    def initialize
      @cache_ttl = 15
      @cache_size = 100
      @consul_uri = "http://consul.service.consul:8500"
    end
  end
end
