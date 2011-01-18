require 'uri'
require 'redis'
require 'em-redis'

module Sinatra
  module RedisHelper
    def redis
      settings.redis
    end

    def async_redis
      settings.async_redis
    end
  end

  module Redis
    def redis=(url)
      @redis = nil
      set :redis_url, url
      redis
    end

    def async_redis=(url)
      @async_redis = nil
      set :redis_url, url
      async_redis
    end

    def redis
      @redis ||= (
        ::Redis.new(
          base_settings
        )
      )
    end

    def async_redis
      @async_redis ||= (
        ::EM::Protocols::Redis.connect(
          base_settings
        )
      )
    end

		private
			def base_settings
        url = URI(redis_url)

        base_settings = {
          :host => url.host,
          :port => url.port,
          :db => url.path[1..-1],
          :password => url.password
        }.merge(redis_settings)
			end

  protected

    def self.registered(app)
      app.set :redis_url, ENV['REDIS_URL'] || "redis://127.0.0.1:6379/0"
      app.set :redis_settings, {}
      app.helpers RedisHelper
    end
  end

  register Redis
end
