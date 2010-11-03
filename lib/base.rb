require 'redis'

# Redis session storage for Rails, and for Rails only. Derived from
# the MemCacheStore code, simply dropping in Redis instead.
#
# Options:
#  :key     => Same as with the other cookie stores, key name
#  :secret  => Encryption secret for the key
#  :host    => Redis host name, default is localhost
#  :port    => Redis port, default is 6379
#  :db      => Database number, defaults to 0. Useful to separate your session storage from other data
#  :key_prefix  => Prefix for keys used in Redis, e.g. myapp-. Useful to separate session storage keys visibly from others
#  :expire_after => A number in seconds to set the timeout interval for the session. Will map directly to expiry in Redis

module RedisSessionStore
  
  class Base < ActionController::Session::AbstractStore
    
    def self.redis=(options)
      namespace ||= :session_store
      @@redis = Redis::Namespace.new(namespace, :redis => Redis.new(@@default_options))
    end

    # Returns the current Redis connection. If none has been created, will
    # create a new one.
    def self.redis
      return @@redis if @@redis
      self.redis = @@default_options
      self.redis
    end

    def initialize(app, options = {})
      super
      @@default_options = {
        :namespace => 'rack:session',
        :host => 'localhost',
        :port => '6379',
        :db => 0,
        :key_prefix => ""
      }.update(options)
      puts self.redis.inspect
    end

    private
      def prefixed(sid)
        "#{@default_options[:key_prefix]}#{sid}"
      end
    
      def get_session(env, sid)
        sid ||= generate_sid
        begin
          data = self.redis.get prefixed(sid)
          session = data.nil? ? {} : Marshal.load(data)
        rescue Errno::ECONNREFUSED
          session = {}
        end
        [sid, session]
      end

      def set_session(env, sid, session_data)
        options = env['rack.session.options']
        expiry  = options[:expire_after] || nil
      
        # redis.multi only works in redis2.
        self.redis.set(prefixed(sid), Marshal.dump(session_data))
        self.redis.expire(prefixed(sid), expiry) if expiry
        
        return true
      rescue Errno::ECONNREFUSED
        return false
      end
  
  end

end
