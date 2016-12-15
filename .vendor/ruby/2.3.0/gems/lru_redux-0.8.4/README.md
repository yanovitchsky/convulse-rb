# LruRedux

An efficient thread safe lru cache.

Lru Redux uses a Hash/Double link list backed storage to keep track of nodes in a cache based on last usage.

This provides a correct and well specified LRU cache, that is very efficient. Additionally you can optionally use a thread safe wrapper.

## Installation

Add this line to your application's Gemfile:

    gem 'lru_redux'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lru_redux

## Usage

```ruby
require 'lru_redux'

# non thread safe
cache = LruRedux::Cache.new(100)
cache[:a] = "1"
cache[:b] = "2"

cache.to_a
# [[:b,"2"],[:a,"1"]]
# note the order matters here, last accessed is first

cache[:a] # a pushed to front
# "1"

cache.to_a
# [[:a,"1"],[:b,"2"]]
cache.delete(:a)
cache.each {|k,v| p "#{k} #{v}"}
# b 2

cache.max_size = 200 # cache now stores 200 items
cache.clear # cache has no items

cache.getset(:a){1}
cache.to_a
#[[:a,1]]

# already set so don't call block
cache.getset(:a){99}
cache.to_a
#[[:a,1]]

# for thread safe access, all methods on cache
# are protected with a mutex
cache = LruRedux::ThreadSafeCache.new(100)

```

## Benchmarks

see: benchmark directory (a million random lookup / store)

```
$ ruby ./bench/bench.rb
Rehearsal ---------------------------------------------------------
thread safe lru         4.530000   0.020000   4.550000 (  4.540861)
lru gem                 2.040000   0.000000   2.040000 (  2.046777)
lru_cache gem           1.660000   0.010000   1.670000 (  1.670404)
lru_redux gem           1.200000   0.000000   1.200000 (  1.197036)
lru_redux thread safe   2.520000   0.000000   2.520000 (  2.526945)
----------------------------------------------- total: 11.980000sec

                            user     system      total        real
thread safe lru         4.550000   0.030000   4.580000 (  4.581848)
lru gem                 2.060000   0.000000   2.060000 (  2.056636)
lru_cache gem           1.660000   0.010000   1.670000 (  1.669312)
lru_redux gem           1.180000   0.000000   1.180000 (  1.187639)
lru_redux thread safe   2.530000   0.000000   2.530000 (  2.532061)

```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changlog

###version 0.8.4 - 20-Feb-2014

- Fix: regression of ThreadSafeCache under JRuby 1.7 @Sevrius

###version 0.8.3 - 20-Feb-2014

- Perf: improve ThreadSafeCache performance @Sevrius

###version 0.8.2 - 16-Feb-2014

- Perf: use #size instead of #count when checking length @Sebrius
- Fix: Cache could grow beyond its size in Ruby 1.8 @Sebrius
- Fix: #each could deadlock in Ruby 1.8 @Sebrius


###version 0.8.1 - 7-Sep-2013

- Fix #each implementation
- Fix deadlocks with ThreadSafeCache
- Version jump is because its been used in production for quite a while now

###version 0.0.6 - 24-April-2013

- Fix bug in getset, overflow was not returning the yeilded val

###version 0.0.5 - 23-April-2013

- Added getset and fetch
- Optimised implementation so it 20-30% faster on Ruby 1.9+

###version 0.0.4 - 23-April-2013

- Initial version
