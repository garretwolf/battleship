require './lib/ship'
require './lib/cell'

class Board

  attr_reader :cells
  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
    }
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include? coordinate
  end

  def horizontal_placement?(coordinates)
    coordinates.all? { |coordinate| coordinate.include? "A" } ||
    coordinates.all? { |coordinate| coordinate.include? "B" } ||
    coordinates.all? { |coordinate| coordinate.include? "C" } ||
    coordinates.all? { |coordinate| coordinate.include? "D" }
  end

  def vertical_placement?(coordinates)
    coordinates.all? { |coordinate| coordinate.include? "1" } ||
    coordinates.all? { |coordinate| coordinate.include? "2" } ||
    coordinates.all? { |coordinate| coordinate.include? "3" } ||
    coordinates.all? { |coordinate| coordinate.include? "4" }
  end

  def consecutive_coordinates?(coordinates)
    if horizontal_placement?(coordinates)
      coordinates.map do |coordinate|
        coordinate.slice!(0)
      end
      coordinates.map! do |coordinate|
        coordinate.to_i
      end
      coordinates.each_cons(2).all? do |x, y|
        y == x + 1
      end
    elsif vertical_placement?(coordinates)
      coordinates.map do |coordinate|
        coordinate.slice!(1)
      end
      coordinates.map! do |coordinate|
        coordinate.tr("ABCD", "1234").to_i
      end
      coordinates.each_cons(2).all? do |x, y|
        y == x + 1
      end
    end
  end

  def valid_placement?(ship, coordinates)
    ship.length == coordinates.count &&
    consecutive_coordinates?(coordinates)
  end
end
