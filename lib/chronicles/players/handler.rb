module Chronicles
  module Players
    class Handler < Concurrent::Actor::Context
      def self.start(name, bard, opts = {})
        spawn(name: :player_handler, link: true, args: [name, bard, opts])
      end

      def self.act(ref)
        ref.ask(:act).value
      end

      def self.get_player(ref)
        ref.ask(:get_player).value
      end

      def self.player_died?(ref)
        get_player(ref).dead?
      end

      def self.quit(ref)
        ref.ask(:quit).value
      end

      def initialize(name, bard, opts)
        @player = Stats.new(name)
        @bard = bard
        @random = opts.fetch(:random, Players::Random.new)
      end

      def on_message(message)
        case message
        when :get_player
          @player
        when :act
          deeds = Actions.do_action(@player, @random)
          @bard.take_notes deeds

          deeds
        when :quit
          @player.die
          @player
        end
      end
    end
  end
end
