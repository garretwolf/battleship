require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

def test_it_exists
  cell = Cell.new("B4")

  assert_instance_of Cell, cell
end

def test_it_has_coordinate
  cell = Cell.new("B4")

  assert_equal "B4", cell.coordinate
end

def test_ship_starts_nil
  cell = Cell.new("B4")

  assert_nil cell.ship
end

def test_coordinates_starts_empty
  cell = Cell.new("B4")

  assert_equal true, cell.empty?
end

def test_it_can_place_ship
  cell = Cell.new("B4")
  cruiser = Ship.new("Cruiser", 3)

  assert_equal cruiser, cell.place_ship(cruiser)
  assert_equal cruiser, cell.ship
  assert_equal false, cell.empty?
end

def test_it_returns_if_fired_upon
  cell = Cell.new("B4")
  cruiser = Ship.new("Cruiser", 3)
  cell.place_ship(cruiser)

  assert_equal false, cell.fired_upon?
end

def test_it_can_return_health_if_fired_upon
  cell = Cell.new("B4")
  cruiser = Ship.new("Cruiser", 3)
  cell.place_ship(cruiser)
  cell.fired_upon
  cell.fire_upon

  assert_equal 2, cell.ship.health
  assert_equal true, cell.fired_upon?
end
end
