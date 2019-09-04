module Chronicles
  # someone to tell about your histories, and propagate your name
  # accross the history
  class Bard
    attr_reader :name

    def initialize
      @name ||= I18n.t(".names").sample
      @verses = []
      @viking_info = {}
    end

    def lyrics_title
      @lyrics_title ||= I18n.t(".titles", name: protagonist).sample
    end

    def destination
      "gabrielleopferreira@gmail.com"
    end

    def take_notes(event)
      @verses << event
    end

    def compose()
      @verses.join("\n")
    end

    def salute
      I18n.t(".welcome").sample
    end

    def remember(info_name, info_data)
      @viking_info[info_name.to_sym] = info_data
    end

    def start_lyrics
      verse = I18n.t(".arrived", name: protagonist).sample

      take_notes(verse)
      verse
    end

    def protagonist
      @viking_info[:name]
    end

    def posthumous_words
      words = I18n.t(".in_memories", name: protagonist).sample
      take_notes(words)

      words
    end
  end
end
