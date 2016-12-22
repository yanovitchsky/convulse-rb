module Convulse
  class Configuration
    attr_accessor :cache_ttl, :cache_size

    def initialize
      @cache_ttl = 15
      @cache_size = 100
    end
  end
end
