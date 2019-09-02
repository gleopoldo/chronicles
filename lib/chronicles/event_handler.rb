module Chronicles
  class EventHandler < Concurrent::Actor::Context
    def self.start(socket)
      spawn(name: :handler, link: true, args: [socket])
    end

    def initialize(socket)
      @socket = socket
      listen
      tell :start
    end

    def on_message(message)
      command, *args = message

      case command
      when :start
        @socket.puts "Hello! What's your name, warrior?"
      when :got
        name = args.first
        @player = Players::Handler.start(name)
        @socket.puts "#{name} has arrived on Savagelands on a magnific boat."

        until Players::Handler.get_player(@player).dead? do
          response = Players::Handler.act(@player)
          @socket.puts response
          sleep 1
        end

        @socket.puts I18n.t(:memories, name: name)
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
