require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def test_it_exists
    cruiser = Ship.new("Cruiser", 3)
    assert_instance_of Ship, cruiser
  end

  def test_if_ship_has_name
    cruiser = Ship.new("Cruiser", 3)
    assert_equal "Cruiser", cruiser.name
  end

  def test_if_ship_has_length
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3, cruiser.length
  end

  def test_if_ship_starts_with_health_equal_to_length
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3, cruiser.health
  end

  def test_if_ship_can_sink
    cruiser = Ship.new("Cruiser", 0)
    assert_equal true, cruiser.sunk?
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, cruiser.sunk?
  end

  def test_if_ship_can_be_hit
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    assert_equal 2, cruiser.health
  end
end
