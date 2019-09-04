require "spec_helper"

RSpec.describe Chronicles::Players::Handler do
  describe ".start" do
    it "creates a player with correct name" do
      handler = described_class.start("olaf")

      expect(described_class.get_player(handler).name).to eq "olaf"
    end
  end

  describe ".act" do
    it "delegates to Action class with correct args" do
      allow(Chronicles::Players::Actions).to receive(:do_action)
      random_seed = double

      handler = described_class.start("Olaf", random: random_seed)
      described_class.act(handler)

      expect(Chronicles::Players::Actions)
        .to have_received(:do_action)
        .with(kind_of(Chronicles::Players::Stats), random_seed)
    end

    it "returns the player" do
      handler = described_class.start("Olaf")
      string = described_class.act(handler)

      expect(string).to be_a_kind_of(String)
    end
  end

  describe ".quit" do
    it "forces the player to commit suicide" do
      handler = described_class.start("Olaf")
      player = described_class.quit(handler)

      expect(player).to be_dead
    end
  end

  describe ".player_died?" do
    it "returns true when the player is dead" do
      handler = described_class.start("Olaf")
      described_class.quit(handler)

      expect(described_class.player_died?(handler)).to be true
    end

    it "returns false otherwise" do
      handler = described_class.start("Olaf")

      expect(described_class.player_died?(handler)).to be false
    end
  end
end
