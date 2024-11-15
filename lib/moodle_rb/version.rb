module MoodleRb
  VERSION = '2.2.0' unless defined?(self::VERSION)

  def self.version
    VERSION
  end
end
