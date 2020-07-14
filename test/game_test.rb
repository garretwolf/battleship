require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_game_has_boards
    game = Game.new
    assert_instance_of Board, game.computer_board
    assert_instance_of Board, game.player_board
  end

  def test_game_has_computer_ships
    game = Game.new
    computer_cruiser = game.computer_ships["Cruiser"]
    computer_submarine = game.computer_ships["Submarine"]
    assert_instance_of Ship, computer_cruiser
    assert_instance_of Ship, computer_submarine
  end

  def test_game_has_player_ships
    game = Game.new
    player_cruiser = game.player_ships["Cruiser"]
    player_submarine = game.player_ships["Submarine"]
    assert_instance_of Ship, player_cruiser
    assert_instance_of Ship, player_submarine
  end

  def test_player_and_computer_starting_ship_sizes_and_health
    game = Game.new
    computer_cruiser = game.computer_ships["Cruiser"]
    computer_submarine = game.computer_ships["Submarine"]
    player_cruiser = game.player_ships["Cruiser"]
    player_submarine = game.player_ships["Submarine"]
    assert_equal 3, computer_cruiser.length
    assert_equal 3, computer_cruiser.health
    assert_equal 2, computer_submarine.length
    assert_equal 2, computer_submarine.length
    assert_equal 3, player_cruiser.length
    assert_equal 3, player_cruiser.health
    assert_equal 2, player_submarine.length
    assert_equal 2, player_submarine.length
  end

  def test_computer_can_place_cruiser
    game = Game.new
    game.computer_place_cruiser
    cruiser_cells = []
    game.computer_board.cells.values.each do |cell|
      if cell.empty? == false
        cruiser_cells << cell
      end
    end
    assert_equal cruiser_cells[0].ship, game.computer_ships["Cruiser"]
    assert_equal cruiser_cells[1].ship, game.computer_ships["Cruiser"]
    assert_equal cruiser_cells[2].ship, game.computer_ships["Cruiser"]
    assert_equal cruiser_cells[3], nil
  end

  def test_computer_can_place_submarine
    game = Game.new
    game.computer_place_submarine
    sub_cells = []
    game.computer_board.cells.values.each do |cell|
      if cell.empty? == false
        sub_cells << cell
      end
    end
    assert_equal sub_cells[0].ship, game.computer_ships["Submarine"]
    assert_equal sub_cells[1].ship, game.computer_ships["Submarine"]
    assert_equal sub_cells[2], nil
  end

  def test_computer_can_place_both_ships
    game = Game.new
    game.computer_place_ships
    ship_cells = []
    game.computer_board.cells.values.each do |cell|
      if cell.empty? == false
        ship_cells << cell
      end
    end
    assert_equal 5, ship_cells.count
  end

  def test_player_can_place_cruiser
    game = Game.new
    game.player_place_cruiser
    cruiser_cells = []
    game.player_board.cells.values.each do |cell|
      if cell.empty? == false
        cruiser_cells << cell
      end
    end
    assert_equal cruiser_cells[0].ship, game.player_ships["Cruiser"]
    assert_equal cruiser_cells[1].ship, game.player_ships["Cruiser"]
    assert_equal cruiser_cells[2].ship, game.player_ships["Cruiser"]
    assert_equal cruiser_cells[3], nil
  end

 def test_player_can_place_submarine
   game = Game.new
   game.player_place_submarine
   sub_cells = []
   game.player_board.cells.values.each do |cell|
     if cell.empty? == false
       sub_cells << cell
     end
   end
   assert_equal sub_cells[0].ship, game.player_ships["Submarine"]
   assert_equal sub_cells[1].ship, game.player_ships["Submarine"]
   assert_equal sub_cells[2], nil
 end

 def test_player_can_place_both_ships
   game = Game.new
   game.player_place_ships
   ship_cells = []
   game.player_board.cells.values.each do |cell|
     if cell.empty? == false
       ship_cells << cell
     end
   end
   assert_equal 5, ship_cells.count
 end

 def test_if_player_can_shoot
   game = Game.new
   game.computer_place_ships
   game.player_shot
   shot = false
   if game.computer_board.render(true).include? "M"
     shot = true
   elsif game.computer_board.render(true).include? "H"
     shot = true
   end
   assert_equal true, shot
 end

 def test_if_computer_can_shoot
   game = Game.new
   game.player_place_ships
   game.computer_shot
   shot = false
   if game.player_board.render(true).include? "M"
     shot = true
   elsif game.player_board.render(true).include? "H"
     shot = true
   end
   assert_equal true, shot
 end
end
