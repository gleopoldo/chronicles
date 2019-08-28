require "state_machines"

module Chronicles
  class Player
    attr_reader :health, :name

    def self.build(name:)
      new(name, {max_health: 100})
    end

    def initialize(name, opts = {})
      @name = name
      @max_health = opts.fetch(:max_health, 100)
      @health = opts[:health] || @max_health
      super()
    end

    state_machine :state, initial: :wandering do
      state :wandering
      state :hunting
      state :sleeping
      state :fighting
      state :dead

      event :hunt do
        transition wandering: :hunting
      end

      event :take_a_nap do
        transition wandering: :sleeping
      end

      event :fight do
        transition [:wandering, :hunting] => :fighting
      end

      event :die do
        transition all => :dead
      end
    end

    def healthy?
      @health == @max_health
    end

    def take_damage(damage)
      @health -= damage
      die if @health <= 0
    end
  end
end
