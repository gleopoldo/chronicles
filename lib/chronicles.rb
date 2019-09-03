require "concurrent"
require "concurrent-edge"
require "i18n"

require "chronicles/version"
require "chronicles/event_handler"
require "chronicles/game"
require "chronicles/player"
require "chronicles/runner"

module Chronicles
  class Error < StandardError; end

  I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]
  I18n.default_locale = :en

  def self.start(host, port)
    Runner.start(host, port)
  end
end
