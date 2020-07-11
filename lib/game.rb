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
      # direct to method to begin setup of game
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

end

require "pry"; binding.pry
