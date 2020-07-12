require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class Turn
  def display_boards
    puts "=============COMPUTER BOARD============="
    puts game.computer_board
    puts "==============PLAYER BOARD=============="
    puts game.player_board
  end
end

# turn = Turn.new
# turn.display_boards
