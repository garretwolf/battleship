class Cell
  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(name)
    @ship = name
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship != nil
      @ship.hit
    end
    @fired_upon = true
  end

  def render(optional_reveal = false)
    if !fired_upon && !empty? && optional_reveal == true
      "S"
    elsif fired_upon? && empty?
      "M"
    elsif fired_upon? && @ship.sunk?
      "X"
    elsif fired_upon? && !empty?
      "H"
    elsif !fired_upon?
      "."
    end
  end
end
