require "spec_helper"

RSpec.describe Chronicles::Players::Handler do
  def build_bard(player_name:)
    bard = Chronicles::Bard.new
    bard.remember(:name, player_name)

    bard
  end

  describe ".start" do
    it "creates a player with correct name" do
      bard = build_bard(player_name: "Olaf")
      handler = described_class.start("olaf", bard)

      expect(described_class.get_player(handler).name).to eq "olaf"
    end
  end

  describe ".act" do
    it "delegates to Action class with correct args" do
      bard = build_bard(player_name: "Olaf")
      allow(Chronicles::Players::Actions).to receive(:do_action)
      random_seed = double

      handler = described_class.start("Olaf", bard, random: random_seed)
      described_class.act(handler)

      expect(Chronicles::Players::Actions)
        .to have_received(:do_action)
        .with(kind_of(Chronicles::Players::Stats), random_seed)
    end

    it "returns the player" do
      bard = build_bard(player_name: "Olaf")
      handler = described_class.start("Olaf", bard)
      string = described_class.act(handler)

      expect(string).to be_a_kind_of(String)
    end

    it "forces the bard to take notes about the player deeds" do
      bard = build_bard(player_name: "Olaf")
      handler = described_class.start("Olaf", bard)
      string = described_class.act(handler)

      expect(bard.compose).to include(string)
    end
  end

  describe ".quit" do
    it "forces the player to commit suicide" do
      bard = build_bard(player_name: "Olaf")
      handler = described_class.start("Olaf", bard)
      player = described_class.quit(handler)

      expect(player).to be_dead
    end
  end

  describe ".player_died?" do
    it "returns true when the player is dead" do
      bard = build_bard(player_name: "Olaf")
      handler = described_class.start("Olaf", bard)
      described_class.quit(handler)

      expect(described_class.player_died?(handler)).to be true
    end

    it "returns false otherwise" do
      bard = build_bard(player_name: "Olaf")
      handler = described_class.start("Olaf", bard)

      expect(described_class.player_died?(handler)).to be false
    end
  end
end
