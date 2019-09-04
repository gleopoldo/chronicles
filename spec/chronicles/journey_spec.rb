require "spec_helper"

RSpec.describe Chronicles::Journey do
  describe "#prepare" do
    it "returns the bard salutation" do
      bard = instance_double(Chronicles::Bard, salute: "Hi!")

      expect(described_class.new(bard: bard).prepare).to eq "Hi!"
    end
  end

  describe "#start" do
    it "records the player name" do
      bard = Chronicles::Bard.new
      journey = described_class.new(bard: bard)

      journey.start("Olaf")

      expect(bard.protagonist).to eq "Olaf"
    end

    it "returns the journey's initial verses" do
      bard = Chronicles::Bard.new
      journey = described_class.new(bard: bard)

      allow(bard).to receive(:start_lyrics).and_return "Once uppon a time..."

      expect(journey.start("Olaf")).to eq "Once uppon a time..."
    end

    it "starts a player agent" do
      bard = Chronicles::Bard.new
      handler = class_double(Chronicles::Players::Handler)
      journey = described_class.new(bard: bard, handler: handler)

      allow(handler).to receive(:start).and_return double
      journey.start("Olaf")

      expect(handler).to have_received(:start).with("Olaf")
    end
  end

  describe "#run" do
    it "keeps playing until player dies" do
      bard = Chronicles::Bard.new
      player = double
      handler = class_double(Chronicles::Players::Handler, start: player)

      allow(handler).to receive(:player_died?).and_return(false, false, true)
      allow(handler).to receive(:act).and_return("text 1", "text 2")

      journey = described_class.new(bard: bard, handler: handler)
      journey.start("Olaf")
      journey.run

      expect(handler).to have_received(:act).twice
    end

    it "yields the player deeds" do
      bard = Chronicles::Bard.new
      player = double
      handler = class_double(Chronicles::Players::Handler, start: player)

      allow(handler).to receive(:player_died?).and_return(false, false, true)
      allow(handler).to receive(:act).and_return("text 1", "text 2")

      journey = described_class.new(bard: bard, handler: handler)
      journey.start("Olaf")

      expect do |expectation|
        journey.run(&expectation)
      end.to yield_successive_args("text 1", "text 2")
    end

    it "records the player deeds" do
      bard = Chronicles::Bard.new
      player = double
      handler = class_double(Chronicles::Players::Handler, start: player)

      allow(handler).to receive(:player_died?).and_return(false, false, true)
      allow(handler).to receive(:act).and_return("text 1", "text 2")

      journey = described_class.new(bard: bard, handler: handler)
      journey.start("Olaf")
      journey.run

      expect(bard.compose).to include "text 1\ntext 2"
    end
  end

  describe "#finish" do
    it "replies with bard's posthumous words" do
      bard = Chronicles::Bard.new
      allow(bard).to receive(:posthumous_words).and_return "the end"

      journey = described_class.new(bard: bard)

      expect(journey.finish).to eq "the end"
    end
  end
end
