module Convulse
  class Cache
     include Singleton

     def initialize
       size = Convulse.configuration.cache_size
       ttl = Convulse.configuration.cache_ttl
       @lru = ::LruRedux::TTL::Cache.new(size, ttl)
     end

     def [](key)
       @lru[key.to_sym]
     end

     def []=(key, value)
       @lru[key.to_sym] = value
     end
  end
end
