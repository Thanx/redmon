module Redmon
  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end

  class Config
    DEFAULTS = {
      :namespace     => (ENV['REDMON_NAMESPACE'] || 'redmon'),
      :redis_url     => (ENV['REDMON_REDIS_URL'] || 'redis://127.0.0.1:6379'),
      :app           => true,
      :worker        => true,
      :web_interface => ['0.0.0.0', 4567],
      :poll_interval => 10,
      :data_lifespan => 30,
      :secure        => (ENV['REDMON_SECURE'] || false)
    }

    attr_accessor(*DEFAULTS.keys)

    def initialize
      apply DEFAULTS
    end

    def apply(opts)
      opts.each { |k,v| send("#{k}=", v) if respond_to? k }
    end

  end
end
