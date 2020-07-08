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
end
