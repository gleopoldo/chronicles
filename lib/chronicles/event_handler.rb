module Chronicles
  class EventHandler < Concurrent::Actor::Context
    def self.start(socket)
      spawn(name: :handler, link: true, args: [socket])
    end

    def initialize(socket)
      @socket = socket
      @journey = Journey.new

      listen
      tell :start
    end

    def on_message(message)
      command, *args = message

      case command
      when :start
        @socket.puts @journey.prepare
      when :got
        @socket.puts @journey.start(args.first)

        @journey.run do |deeds|
          @socket.puts deeds
          sleep 1
        end

        @socket.puts @journey.finish
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
