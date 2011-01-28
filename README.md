Sinatra Redis Extension
========================

Extends [Sinatra](http://www.sinatrarb.com/) with an extension method for
dealing with redis databases using the [redis-rb](http://github.com/ezmobius/redis-rb) client library that
comes with the redis source (pre-packaged with this library for convenience).
You can Install the `sinatra-redis` with rip

    $ rip install git://github.com/bmizerany/sinatra-redis.git

or
    $ gem install sinatra-redis -s http://gemcutter.org
or

    $ gem install bmizerany-sinatra-redis -s http://gems.github.com

and use like:

    $ vim sinatra-using-redis.rb

    require 'sinatra'
    require 'sinatra/redis'

    # Establish the database connection; or, omit this and use the REDIS_URL
    # environment variable as the connection string; or, default to redis://locahost:6379/0
    #
    # NOTE: The database is the integer in the path
    # set :redis, 'redis://some-remote-server:1234/5' 

    # At this point, you can access the Redis object using the "redis" object:
    puts redis.delete "foos"
    puts redis.rpush "foos", "redis"
    puts redis.rpush "foos", "is"
    puts redis.rpush "foos", "sweet!"

    # access redis within the context of an HTTP request
    get '/foos' do
      @foos = redis.lrange("foos", 0, -1) # Array
      @foos.inspect
    end

    $ ruby sinatra-using-redis.rb

### Redis Reference Material

  * The [Redis Wiki](http://redis.io/documentation)

  * The [Redis Command Reference](http://redis.io/commands)

  * The [Redis Source](http://github.com/antirez/redis)

  * Ezra's Mountain West Ruby Conf '09 [Talk](http://confreaks.net/videos/62-mwrc2009-redis-key-value-nirvana)

### NOTE about the rip-off

  This Code and README.md is a heavy adaption of [rtomayko's sinatra-sequel](http://github.com/rtomayko/sinatra-sequel/)
