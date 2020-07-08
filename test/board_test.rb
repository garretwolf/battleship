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

    assert board.horizontal_placement?(["A1", "A2", "A3"])
    refute board.horizontal_placement?(["A1", "B1"])
  end

  def test_if_placement_is_vertical
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.vertical_placement?(["A1", "A2", "A3"])
    assert board.vertical_placement?(["A1", "B1"])
  end

  def test_if_coordinates_are_consecutive
    board = Board.new

    assert board.consecutive_coordinates?(["A1", "A2", "A3"])
    assert board.consecutive_coordinates?(["C2", "C3", "C4"])
    assert board.consecutive_coordinates?(["A1", "A2"])
    assert board.consecutive_coordinates?(["A1", "B1"])
    assert board.consecutive_coordinates?(["B3", "C3", "D3"])
    refute board.consecutive_coordinates?(["A1", "A2", "A4"])
    refute board.consecutive_coordinates?(["A2", "A1"])
    refute board.consecutive_coordinates?(["B1", "C1", "D2"])
    refute board.consecutive_coordinates?(["D3", "D1", "D2"])
  end

  def test_if_placement_is_valid
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2"])
    refute board.valid_placement?(submarine, ["A2", "A3", "A4"])
    refute board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute board.valid_placement?(submarine, ["A1", "C1"])
    refute board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    refute board.valid_placement?(submarine, ["C1", "B1"])
    refute board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    refute board.valid_placement?(submarine, ["C2", "D3"])
    assert board.valid_placement?(submarine, ["A1", "A2"])
    assert board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

end

# def test_if_coordinates_are_consecutive
#   board = Board.new
#   coordinates1 = ["A1", "A2"]
#   coordinates2 = ["A2", "A3", "A4"]
#   coordinates3 = ["B3", "B4"]
#   coordinates4 = ["B1", "B2", "B4"]
#
#   assert_equal true, board.consecutive_coordinates?(coordinates1)
#   assert_equal true, board.consecutive_coordinates?(coordinates2)
#   assert_equal true, board.consecutive_coordinates?(coordinates3)
#   assert_equal false, board.consecutive_coordinates?(coordinates4)
# end

#
# def test_if_placement_with_valid_number_of_coordinates_fails_if_not_consecutive
#   board = Board.new
#   submarine = Ship.new("Submarine", 2)
#
#   assert_equal false, board.valid_placement?(submarine, ["A2", "A4"])
# end
