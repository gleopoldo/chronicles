module Chronicles
  class Journey
    def initialize(opts)
      @bard = opts.fetch(:bard, Bard.new)
      @email = opts.fetch(:email, nil)
      @herald = opts.fetch(:herald, Herald.new)
      @handler = opts.fetch(:handler, Players::Handler)
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
      words = @bard.posthumous_words
      @herald.send_message!(@bard, @email) unless @email.nil?

      words
    end
  end
end
