module Chronicles
  module Players
    # This class practically rools the dices to check if a player
    # can do some actions
    #
    # The intent here is to isolate randomicity from deterministic function
    # calls. This is easier to test, then.
    class Random
      Action = Struct.new(:success?, :dead?)

      def try_wake_up
        Action.new(roll_dices_with_success?(2), roll_dices_with_success?(2))
      end

      def try_hunt
        Action.new(roll_dices_with_success?, roll_dices_with_success?)
      end

      private

      def roll_dices_with_success?(possibilities = 3)
        ::Random.rand(possibilities).zero?
      end
    end
  end
end
