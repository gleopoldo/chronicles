require "spec_helper"

RSpec.describe Chronicles::Runner do
  describe ".start" do
    it "starts and stops a TCP server" do
      port = 40000
      host = "0.0.0.0"

      server = described_class.start(host, port)
      socket = TCPSocket.new(host, port)
      described_class.stop(server)

      expect do
        TCPSocket.new(host, port)
      end.to raise_error Errno::ECONNREFUSED
    end

    it "allows a communication setup to be made" do
      port = 40000
      host = "0.0.0.0"
      bard = Chronicles::Bard.new

      allow(Chronicles::Bard).to receive(:new).and_return bard

      server = described_class.start(host, port)
      socket = TCPSocket.new(host, port)

      ask = socket.gets.chomp
      expect(ask).to be_a_kind_of(String)

      name = "Olaf"
      socket.puts name

      verses = ""

      while(output = socket.gets) do
        verses << output if output
      end

      expect(verses.strip.force_encoding("ISO-8859-1"))
        .to eq bard.compose.force_encoding("ISO-8859-1")
    end
  end
end
