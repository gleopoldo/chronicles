module Chronicles
  class EventHandler < Concurrent::Actor::Context
    def self.start(socket)
      spawn(name: :handler, link: true, args: [socket])
    end

    def initialize(socket)
      @socket = socket
      @bard = Bard.new

      listen
      tell :start
    end

    def on_message(message)
      command, *args = message

      case command
      when :start
        @socket.puts @bard.salute
      when :got
        name = args.first
        @bard.remember("name", name)
        @player = Players::Handler.start(name)
        @socket.puts @bard.start_lyrics

        until Players::Handler.get_player(@player).dead? do
          deeds = Players::Handler.act(@player)
          @bard.take_notes(deeds)

          @socket.puts deeds
          sleep 1
        end

        @socket.puts @bard.posthumous_words
        @socket.close
      end
    end

    private

    def listen
      Thread.new do
        until @socket.closed? do
          begin
            message = @socket.gets.chomp
            tell([:got, message])
          rescue IOError
          end
        end
      end
    end
  end
end
