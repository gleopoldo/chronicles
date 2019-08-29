require "spec_helper"

RSpec.describe Chronicles::Players::Actions do
  def build_player
    Chronicles::Players::Stats.new("olaf")
  end

  context "when player is wandering" do
    it "sets the player to hunting state" do
      player = build_player
      random = instance_double(Chronicles::Players::Random,
                               try_hunt: double(success?: true))
      described_class.do_action(player, random)

      expect(player).to be_hunting
    end

    it "may keep wandering" do
      player = build_player
      random = instance_double(Chronicles::Players::Random,
                               try_hunt: double(success?: false))
      described_class.do_action(player, random)

      expect(player).to be_wandering
    end
  end

  context "when player is hunting" do
    it "keeps the player hunting" do
      random = instance_double(Chronicles::Players::Random,
                               try_hunt: double(success?: true))
      player = build_player
      player.hunt

      described_class.do_action(player, random)

      expect(player).to be_hunting
    end

    it "may kill the player in an accident" do
      random = instance_double(Chronicles::Players::Random,
                               try_hunt: double(success?: false,
                                                die_reason: "Found a ferocious cat"))
      player = build_player
      player.hunt

      described_class.do_action(player, random)

      expect(player).to be_dead
    end
  end

  context "when player is sleeping" do
    it "may keep sleeping" do
      random = instance_double(Chronicles::Players::Random,
                               try_wake_up: double(success?: false,
                                                   die_reason: nil))
      player = build_player
      player.take_a_nap

      described_class.do_action(player, random)

      expect(player).to be_sleeping
    end

    it "may die while sleeping" do
      random = instance_double(Chronicles::Players::Random,
                               try_wake_up: double(
                                 success?: false,
                                 die_reason: "Lots of mosquitoes can kill"))
      player = build_player
      player.take_a_nap

      described_class.do_action(player, random)

      expect(player).to be_dead
    end

    it "wakes up and starts wandering" do
      random = instance_double(Chronicles::Players::Random,
                               try_wake_up: double(success?: true))
      player = build_player
      player.take_a_nap

      described_class.do_action(player, random)

      expect(player).to be_wandering
    end
  end
end
