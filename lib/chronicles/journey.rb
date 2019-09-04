module Chronicles
  class Journey
    def initialize(bard: Bard.new, handler: Players::Handler)
      @bard = bard
      @handler = handler
    end

    def prepare
      @bard.salute
    end

    def start(player_name)
      @bard.remember("name", player_name)
      @player = @handler.start(player_name, @bard)

      @bard.start_lyrics
    end

    def run
      until @handler.player_died?(@player) do
        deeds = @handler.act(@player)

        yield(deeds) if block_given?
      end
    end

    def finish
      @bard.posthumous_words
    end
  end
end
