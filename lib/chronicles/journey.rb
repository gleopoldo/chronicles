module Chronicles
  class Journey
    def initialize(herald: Herald.new, bard: Bard.new, handler: Players::Handler)
      @bard = bard
      @herald = herald
      @handler = handler
    end

    def prepare
      @bard.salute
    end

    def start(player_name)
      @bard.remember("name", player_name)
      @player = @handler.start(player_name)

      @bard.start_lyrics
    end

    def run
      until @handler.player_died?(@player) do
        deeds = @handler.act(@player)
        @bard.take_notes(deeds)

        yield(deeds) if block_given?
      end
    end

    def finish
      @bard.posthumous_words
      @herald.send_message!(@bard)
    end
  end
end
