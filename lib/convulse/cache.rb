module Convulse
  class Cache
     include Singleton

     def initialize
       @lru = ::LruRedux::TTL::Cache.new(100, 11)
     end

     def [](key)
       @lru[key.to_sym]
     end

     def []=(key, value)
       @lru[key.to_sym] = value
     end
  end
end
