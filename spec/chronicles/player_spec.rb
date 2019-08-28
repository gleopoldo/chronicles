require "spec_helper"

RSpec.describe Chronicles::Player do
  describe ".build" do
    it "creates a new player" do
      expect(described_class.build(name: "olaf"))
        .to be_a_kind_of(Chronicles::Player)
    end

    it "builds a healthy adventurer" do
      player = described_class.build(name: "olaf")

      expect(player).to be_healthy
    end

    it "build a new adventurer with a initial state 'wandering'" do
      player = described_class.build(name: "olaf")

      expect(player).to be_wandering
    end
  end

  describe "healthy?" do
    it "returns true when life is on its maximum" do
      player = described_class.new("olaf", health: 100, max_health: 100)

      expect(player).to be_healthy
    end

    it "returns false when life is not at maximum" do
      player = described_class.new("olaf", health: 99, max_health: 100)

      expect(player).to_not be_healthy
    end
  end

  describe "#hunt!" do
    it "begins hunting something right after he was wandering" do
      player = described_class.new("olaf")
      player.hunt

      expect(player).to be_hunting
    end

    it "cannot hunt when he is sleeping" do
      player = described_class.new("olaf")
      player.take_a_nap
      player.hunt

      expect(player).to_not be_hunting
    end
  end

  describe "#take_a_nap!" do
    it "begins sleeping right after he was wandering" do
      player = described_class.new("olaf")
      player.take_a_nap

      expect(player).to be_sleeping
    end

    it "cannot sleep when he is hunting" do
      player = described_class.new("olaf")
      player.hunt
      player.take_a_nap

      expect(player).to_not be_sleeping
    end
  end

  describe "#fight!" do
    it "begins fighting right after he was hunting" do
      player = described_class.new("olaf")
      player.hunt
      player.fight

      expect(player).to be_fighting
    end

    it "begins fighting right after he was wandering" do
      player = described_class.new("olaf")
      player.fight

      expect(player).to be_fighting
    end

    it "cannot start fighting when he was sleeping" do
      player = described_class.new("olaf")
      player.take_a_nap
      player.fight

      expect(player).to_not be_fighting
    end
  end

  describe "#take_damage" do
    it "hurts itself with an amount of damage" do
      damage = 10
      player = described_class.new("olaf")
      player.take_damage(damage)

      expect(player.health).to eq 90
      expect(player).to_not be_dead
    end

    it "may kill a player" do
      damage = 100
      player = described_class.new("olaf")
      player.take_damage(damage)

      expect(player.health).to eq 0
      expect(player).to be_dead
    end
  end
end
