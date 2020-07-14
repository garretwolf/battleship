require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/variable_board'

class VariableBoardTest < Minitest::Test
  def test_it_exists
    board = VariableBoard.new

    assert_instance_of VariableBoard, board
  end

  def test_it_can_generate_columns
    board = VariableBoard.new
    board.generate_columns

    assert board.columns.count > 0
  end

  def test_it_can_generate_rows
    board = VariableBoard.new

    board.generate_columns
    board.generate_rows
    assert_equal board.columns.count, board.rows.count
  end

  def test_it_can_generate_cells
    board = VariableBoard.new
    board.generate_columns
    board.generate_rows
    board.generate_cells

    assert_equal board.cells.keys.count, board.columns.count * board.rows.count
  end

end
