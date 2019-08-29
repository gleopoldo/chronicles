module Chronicles
  module Players
    class Actions
      def self.do_action(player, random = Random)
        case true
        when player.wandering?
          player.hunt
        when player.sleeping?
          action = random.try_wake_up
          if action.success?
            player.wake_up
          elsif !action.die_reason.nil?
            player.die
          end
        end
      end
    end
  end
end
