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

    it "returns a string" do
      verses = described_class.do_action(build_player)
      expect(verses).to be_a_kind_of(String)
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
                                                dead?: true))
      player = build_player
      player.hunt

      described_class.do_action(player, random)

      expect(player).to be_dead
    end

    it "returns a string" do
      player = build_player
      player.hunt

      verses = described_class.do_action(player)
      expect(verses).to be_a_kind_of(String)
    end
  end

  context "when player is sleeping" do
    it "may keep sleeping" do
      random = instance_double(Chronicles::Players::Random,
                               try_wake_up: double(success?: false,
                                                   dead?: false))
      player = build_player
      player.take_a_nap

      described_class.do_action(player, random)

      expect(player).to be_sleeping
    end

    it "may die while sleeping" do
      random = instance_double(Chronicles::Players::Random,
                               try_wake_up: double(
                                 success?: false,
                                 dead?: true))
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

    it "returns a string" do
      player = build_player
      player.take_a_nap

      verses = described_class.do_action(player)
      expect(verses).to be_a_kind_of(String)
    end
  end
end
