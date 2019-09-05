require "socket"

module Chronicles
  class Runner < Concurrent::Actor::Context
    def self.start(host, port, options = {})
      server = TCPServer.new(host, port)

      spawn(name: :runner, link: true, args: [server, options])
    end

    def self.stop(server)
      server.ask(:stop).value
    end

    def initialize(server, options)
      @server = server
      @options = options
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
        EventHandler.start(socket, @options)
      end
    end

    private

    def start
      @thread = Thread.new(@server) do |server|
        while true
          break if server.closed?

          begin
            tell [:accept, server.accept]
          rescue Errno::EINVAL
          end
        end
      end
    end

    def stop
      @server.shutdown
    end
  end
end
