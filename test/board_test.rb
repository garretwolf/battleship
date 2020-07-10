require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_if_board_has_16_cells
    board = Board.new
    board.cells

    assert_equal 16, board.cells.keys.count
    assert_equal 16, board.cells.values.count
  end

  def test_if_coordinate_is_valid
    board = Board.new
    board.cells

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("B2")
    assert_equal true, board.valid_coordinate?("C3")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("Z8")
  end

  def test_if_placement_is_valid_based_on_ship_length_and_number_of_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, board.valid_placement?(submarine, ["A2", "A3"])
  end

  def test_if_placement_is_horizontal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.horizontal_placement?(["A1", "A2", "A3"])
    assert_equal false, board.horizontal_placement?(["A1", "B1"])
  end

  def test_if_placement_is_vertical
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.vertical_placement?(["A1", "A2", "A3"])
    assert_equal true, board.vertical_placement?(["A1", "B1"])
  end

  def test_if_coordinates_are_consecutive
    board = Board.new

    assert_equal true, board.consecutive_coordinates?(["A1", "A2", "A3"])
    assert_equal true, board.consecutive_coordinates?(["C2", "C3", "C4"])
    assert_equal true, board.consecutive_coordinates?(["A1", "A2"])
    assert_equal true, board.consecutive_coordinates?(["A1", "B1"])
    assert_equal true, board.consecutive_coordinates?(["B3", "C3", "D3"])
    assert_equal false, board.consecutive_coordinates?(["A1", "A2", "A4"])
    assert_equal false, board.consecutive_coordinates?(["A2", "A1"])
    assert_equal false, board.consecutive_coordinates?(["B1", "C1", "D2"])
    assert_equal false, board.consecutive_coordinates?(["D3", "D1", "D2"])
  end

  def test_if_placement_is_valid
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_it_can_place_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    cell_1.ship
    cell_2.ship
    cell_3.ship

    assert_equal true, cell_3.ship == cell_2.ship
  end

  def test_if_placement_is_invalid_if_cell_has_ship_already
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    cell_1.ship
    cell_2.ship
    cell_3.ship
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(submarine, ["D1", "D2"])
  end

  def test_if_board_can_render
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(cruiser, ["A1", "A2", "A3"])
    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", board.render
    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", board.render(true)
    board.place(submarine, ["D1", "D2"])
    board.cells["A1"].fire_upon
    board.cells["A2"].fire_upon
    board.cells["A3"].fire_upon
    assert_equal "  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n", board.render
    assert_equal "  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD S S . . \n", board.render(true)
  end
end
