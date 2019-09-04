module Chronicles
  module Players
    class Actions
      class << self
        def do_action(player, random = Random.new)
          case true
          when player.wandering?
            wandering(player, random)

          when player.hunting?
            hunting(player, random)

          when player.sleeping?
            sleeping(player, random)
          end

          I18n.t(player.state_name).sample
        end

        private

        def wandering(player, random)
          action = random.try_hunt
          if action.success?
            player.hunt
          else
            action = random.try_sleep
            player.take_a_nap if action.success?
          end
        end

        def hunting(player, random)
          action = random.try_hunt
          player.die if !action.success?
        end

        def sleeping(player, random)
          action = random.try_wake_up
          if action.success?
            player.wake_up
          elsif action.dead?
            player.die
          end
        end
      end
    end
  end
end
