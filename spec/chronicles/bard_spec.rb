require "spec_helper"

RSpec.describe Chronicles::Bard do
  describe "#compose" do
    it "take notes about something" do
      bard = described_class.new

      bard.take_notes "Olaf was a great warrior"
      bard.take_notes "Olaf was trying to become the greatest warrior in Britain"
      bard.take_notes "Olaf was known as 'the Swordsman'"
      bard.take_notes "Olaf died in blazes of glory when fighting with a dragon"

      expect(bard.compose).to eq %Q(
        Olaf was a great warrior
        Olaf was trying to become the greatest warrior in Britain
        Olaf was known as 'the Swordsman'
        Olaf died in blazes of glory when fighting with a dragon
      ).gsub(/\ \ +/, "").strip
    end
  end

  describe "#salute" do
    it "attempts to know a player" do
      bard = described_class.new
      salutations = I18n.t(".welcome")

      expect(salutations).to include bard.salute
    end

    it "does not takes notes about this meeting" do
      bard = described_class.new
      salute = bard.salute

      expect(bard.compose).to_not include salute
    end
  end

  describe "#start_lyrics" do
    it "starts the history" do
      bard = described_class.new
      bard.remember(:name, "Bob")
      arrivals = I18n.t(".arrived", name: "Bob")

      expect(arrivals).to include bard.start_lyrics
    end

    it "take notes" do
      bard = described_class.new
      bard.remember(:name, "Bob")
      the_beginning = bard.start_lyrics

      expect(bard.compose).to include(the_beginning)
    end
  end

  describe "#posthumous_words" do
    it "ends the history" do
      bard = described_class.new
      bard.remember(:name, "Bob")
      ends = I18n.t(".in_memories", name: "Bob")

      expect(ends).to include bard.posthumous_words
    end
  end
end
