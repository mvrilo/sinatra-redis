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
