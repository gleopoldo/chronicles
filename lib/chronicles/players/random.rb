module Chronicles
  module Players
    # This class practically rools the dices to check if a player
    # can do some actions
    #
    # The intent here is to isolate randomicity from deterministic function
    # calls. This is easier to test, then.
    class Random
      Action = Struct.new(:success?)

      def try_wake_up
        Action.new(Random.rand(2).zero?)
      end
    end
  end
end
