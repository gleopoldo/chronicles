require "concurrent"
require "concurrent-edge"
require "i18n"

require "chronicles/version"
require "chronicles/player"
require "chronicles/bard"
require "chronicles/herald"
require "chronicles/journey"
require "chronicles/runner"
require "chronicles/event_handler"

module Chronicles
  class Error < StandardError; end

  I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]
  I18n.default_locale = :en

  def self.start(host, port)
    Runner.start(host, port)
  end
end
