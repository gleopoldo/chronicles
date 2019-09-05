module Chronicles
  class EventHandler < Concurrent::Actor::Context
    def self.start(socket, options = {})
      spawn(name: :handler, link: true, args: [socket, options])
    end

    def initialize(socket, options)
      @socket = socket
      @journey = Journey.new(options)

      listen
      tell :start
    end

    def on_message(message)
      command, *args = message

      case command
      when :start
        @socket.puts @journey.prepare
      when :got
        join_new_adventure(args.first)
      end
    end

    private

    def join_new_adventure(player_name)
      @socket.puts @journey.start(player_name)

      @journey.run do |deeds|
        @socket.puts deeds
        sleep 1
      end

      @socket.puts @journey.finish
      @socket.close
    end

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
