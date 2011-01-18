require 'rubygems'
require 'sinatra'
require File.expand_path(File.dirname(__FILE__)) + '/../lib/sinatra/redis.rb'

get '/' do
	redis.del 'key'
	EM.run do
		async_redis.setnx 'key', Time.now.to_i do |ok|
			puts "Result: #{ok}"
			puts "Should not return nil: #{redis.get('key')}"
		end
	end

	puts "Should return nil: #{redis.get('key')}"

	"render some text"
end
