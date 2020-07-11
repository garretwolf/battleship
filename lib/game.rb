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

  def computer_place_ships
    shuffled = @computer_board.cells.keys.shuffle[0..2]
    if @computer_board.valid_placement?(@computer_ships["Cruiser"], shuffled)
      @computer_board.place(@computer_ships["Cruiser"], shuffled)
    elsif @computer_board.valid_placement?(@computer_ships["Submarine"], shuffled[0..1])
      @computer_board.place(@computer_ships["Submarine"], shuffled[0..1])
    else
      computer_place_ships
    end
  end 

end

require "pry"; binding.pry
