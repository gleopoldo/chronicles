module Chronicles
  class Game
    def self.start()
      puts "This is a new adventure. Please enter your name:"
      name = gets.chomp

      player = Player.build(name: name)
      puts "Welcome, #{player.name}"

      new(player)
    end

    def initialize(player)
      @player = player
    end
  end
end
