require './lib/ship'
require './lib/cell'
require 'pry'

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
    coordinates.map {|coordinate| coordinate[0]}.uniq.count == 1
  end

  def vertical_placement?(coordinates)
    coordinates.map {|coordinate| coordinate[1]}.uniq.count == 1
  end

  def consecutive_coordinates?(coordinates)
    if horizontal_placement?(coordinates)
      integers = coordinates.map {|coordinate| coordinate[1].to_i}
      integers.each_cons(2).all? {|x, y| y == x + 1}
    elsif vertical_placement?(coordinates)
      integers = coordinates.map {|coordinate| coordinate[0].ord}
      integers.each_cons(2).all? {|x, y| y == x + 1}
    else
      false
    end
  end

  def valid_placement?(ship, coordinates)
    coordinates.all? {|cell| @cells[cell].empty?} &&
    coordinates.all? {|coordinate| valid_coordinate?(coordinate)} &&
    ship.length == coordinates.count &&
    consecutive_coordinates?(coordinates)
  end
# Place method can be refactored
  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |cell|
        @cells[cell].place_ship(ship)
        end
    end
  end
#NOT WORKING PERFECTLY
  def render(optional_reveal = false)
    if optional_reveal == true
      "  1 2 3 4\n" +"A #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)}\n" +"B #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)}\n" +"C #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)}\n" +"D #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)}"
    else
      "  1 2 3 4\nA #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render}\nB #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render}\nC #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render}\nD #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render}"
    end
  end
end

# board = Board.new
# cruiser = Ship.new("Cruiser", 3)
# submarine = Ship.new("Submarine", 2)
# board.place(cruiser, ["A1", "A2", "A3"])
# board.place(submarine, ["D1", "D2"])
# board.cells["A1"].fire_upon
# board.cells["A2"].fire_upon
# board.cells["A3"].fire_upon
# #NOT PERFECT
# board.render
