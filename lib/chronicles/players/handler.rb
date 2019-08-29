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

      def initialize(name, opts)
        @player = Stats.new(name)
        @random = opts.fetch(:random, Random)
      end

      def on_message(message)
        case message
        when :get_player
          @player
        when :act
          Actions.do_action(@player, @random)
          @player
        end
      end
    end
  end
end
