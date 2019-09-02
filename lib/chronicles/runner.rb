require "socket"

module Chronicles
  class Runner < Concurrent::Actor::Context
    def self.start(host, port)
      server = TCPServer.new(host, port)

      spawn(name: :runner, link: true, args: [server])
    end

    def self.stop(server)
      server.ask(:stop).value
    end

    def initialize(server)
      @server = server
      self << :start
    end

    def on_message(message)
      command, *args = message

      case command
      when :start
        start
      when :stop
        stop
      when :accept
        socket = args.first
        EventHandler.start(socket)
      end
    end

    private

    def start
      @thread = Thread.new(@server) do |server|
        while true
          break if server.closed?

          tell [:accept, server.accept]
        end
      end
    end

    def stop
      @server.shutdown
    end
  end
end
