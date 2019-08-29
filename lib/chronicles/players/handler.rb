module Chronicles
  module Players
    class Handler < Concurrent::Actor::Context
      def self.start(name, opts = {})
        spawn(name: :player_handler, link: true, args: [name, opts])
      end

      def self.act(ref)
        ref.ask(:act).value
      end

      def self.get_player(ref)
        ref.ask(:get_player).value
      end

      def self.quit(ref)
        ref.ask(:quit).value
      end

      def initialize(name, opts)
        @player = Stats.new(name)
        @random = opts.fetch(:random, Players::Random.new)
      end

      def on_message(message)
        case message
        when :get_player
          @player
        when :act
          Actions.do_action(@player, @random)
        when :quit
          @player.die
        end

        @player
      end
    end
  end
end
