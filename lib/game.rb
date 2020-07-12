require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

attr_reader :player_board,
            :computer_board,
            :player_ships,
            :computer_ships
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_ships = {
      "Cruiser" => Ship.new("Cruiser", 3),
      "Submarine" => Ship.new("Submarine", 2)
    }
    @computer_ships = {
      "Cruiser" => Ship.new("Cruiser", 3),
      "Submarine" => Ship.new("Submarine", 2)
    }
  end

  def start
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit"
    user_response = gets.chomp.downcase
    if user_response == "p"
      computer_place_ships
      player_place_ships
    elsif user_response == "q"
      p "You have quit the game."
      exit
    else
      p "That is not a valid response. Please try again."
      start
    end
  end

  def computer_place_cruiser
    shuffled = @computer_board.cells.keys.shuffle[0..2]
    if @computer_board.valid_placement?(@computer_ships["Cruiser"], shuffled)
      @computer_board.place(@computer_ships["Cruiser"], shuffled)
    else
      computer_place_cruiser
    end
  end

  def computer_place_submarine
    shuffled = @computer_board.cells.keys.shuffle[0..1]
    if @computer_board.valid_placement?(@computer_ships["Submarine"], shuffled)
      @computer_board.place(@computer_ships["Submarine"], shuffled)
    else
      computer_place_submarine
    end
  end

  def computer_place_ships
    computer_place_cruiser
    computer_place_submarine
  end

  def player_place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render(true)
    player_place_cruiser
  end

  def print_player_board
    puts @player_board.render(true)
  end

  def player_place_cruiser
    puts "Enter the squares for the Cruiser (3 spaces):"
    print ">"
    player_response = gets.chomp.upcase.split(" ")

    if @player_board.valid_placement?(@player_ships["Cruiser"], player_response)
      @player_board.place(@player_ships["Cruiser"], player_response)
      print_player_board
    else
      puts "Those are invalid coordinates. Please try again:"
      print ">"
      player_place_cruiser
    end
    player_place_submarine
  end

  def player_place_submarine
    puts "Enter the squares for the Submarine (2 spaces):"
    print ">"
    player_response = gets.chomp.upcase.split(" ")
    if @player_board.valid_placement?(@player_ships["Submarine"], player_response)
      @player_board.place(@player_ships["Submarine"], player_response)
      print_player_board
    else
      puts "Those are invalid coordinates. Please try again:"
      print ">"
      player_place_submarine
    end
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end
end

game = Game.new
game.display_boards
