class Game

attr_reader :player_board,
            :computer_board,
            :player_ships,
            :computer_ships
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_ships = {
      "Cruiser" => Ship.new("Cruiser", 3),
      "Submarine" => Ship.new("Submarine", 2)
    }
    @computer_ships = {
      "Cruiser" => Ship.new("Cruiser", 3),
      "Submarine" => Ship.new("Submarine", 2)
    }
  end

  def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
    user_response = gets.chomp.downcase
    if user_response == "p"
      computer_place_ships
      player_place_ships
      turn
    elsif user_response == "q"
      puts "You have quit the game."
      exit
    else
      puts "That is not a valid response. Please try again."
      start
    end
  end

  def computer_place_ships
    computer_place_cruiser
    computer_place_submarine
  end

  def computer_place_cruiser
    shuffled = @computer_board.cells.keys.shuffle[0..2]
    if @computer_board.valid_placement?(@computer_ships["Cruiser"], shuffled)
      @computer_board.place(@computer_ships["Cruiser"], shuffled)
    else
      computer_place_cruiser
    end
  end

  def computer_place_submarine
    shuffled = @computer_board.cells.keys.shuffle[0..1]
    if @computer_board.valid_placement?(@computer_ships["Submarine"], shuffled)
      @computer_board.place(@computer_ships["Submarine"], shuffled)
    else
      computer_place_submarine
    end
  end

  def print_player_board
    puts @player_board.render(true)
  end

  def player_place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    print_player_board
    player_place_cruiser
    player_place_submarine
  end


  def player_place_cruiser
    puts "Enter the squares for the Cruiser (3 spaces):"
    print ">"
    player_response = gets.chomp.upcase.split(" ")
    if player_response.count == 3 && @player_board.valid_placement?(@player_ships["Cruiser"], player_response)
      @player_board.place(@player_ships["Cruiser"], player_response)
      print_player_board
    else
      puts "Those are invalid coordinates. Please try again:"
      print ">"
      player_place_cruiser
    end
  end

  def player_place_submarine
    puts "Enter the squares for the Submarine (2 spaces):"
    print ">"
    player_response = gets.chomp.upcase.split(" ")
    if player_response.count == 2 && @player_board.valid_placement?(@player_ships["Submarine"], player_response)
      @player_board.place(@player_ships["Submarine"], player_response)
      print_player_board
    else
      puts "Those are invalid coordinates. Please try again:"
      print ">"
      player_place_submarine
    end
  end

  def turn
    display_boards
    player_shot
      if @computer_ships["Cruiser"].sunk? && @computer_ships["Submarine"].sunk?
        puts "You won!"
        initialize
        start
      end
    computer_shot
      if @player_ships["Cruiser"].sunk? && @player_ships["Submarine"].sunk?
        puts "I won!"
        initialize
        start
      end
    turn
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def player_fire_upon(coordinate)
    @computer_board.cells[coordinate].fire_upon
    if @computer_board.cells[coordinate].render == "M"
      puts "Your shot on #{coordinate} was a miss."
    elsif @computer_board.cells[coordinate].render == "H"
      puts "Your shot on #{coordinate} was a direct hit!"
    elsif @computer_board.cells[coordinate].render == "X"
      puts "Your shot on #{coordinate} sunk my ship!"
    end
  end

  def player_shot
    puts "Enter the coordinate for your shot:"
    print ">"
    player_shot_coordinate = gets.chomp.upcase.to_s
    if @computer_board.valid_coordinate?(player_shot_coordinate) == false
      player_shot_invalid
    elsif @computer_board.cells[player_shot_coordinate].fired_upon?
      player_shot_already_fired
    else
      player_fire_upon(player_shot_coordinate)
    end
  end

  def player_shot_invalid
    puts "Please enter a valid coordinate:"
    print ">"
    player_shot_coordinate = gets.chomp.upcase.to_s
    if @computer_board.valid_coordinate?(player_shot_coordinate) == false
      player_shot_invalid
    elsif @computer_board.cells[player_shot_coordinate].fired_upon?
      player_shot_already_fired
    else
      player_fire_upon(player_shot_coordinate)
    end
  end

  def player_shot_already_fired
    puts "You have already fired upon this coordinate. Please enter a valid coordinate:"
    print ">"
    player_shot_coordinate = gets.chomp.upcase.to_s
    if @computer_board.valid_coordinate?(player_shot_coordinate) == false
      player_shot_invalid
    elsif @computer_board.cells[player_shot_coordinate].fired_upon?
      player_shot_already_fired
    else
      player_fire_upon(player_shot_coordinate)
    end
  end


  def computer_fire_upon(coordinate)
    @player_board.cells[coordinate].fire_upon
    if @player_board.cells[coordinate].render == "M"
      puts "My shot on #{coordinate} was a miss."
    elsif @player_board.cells[coordinate].render == "H"
      puts "My shot on #{coordinate} was a direct hit!"
    elsif @player_board.cells[coordinate].render == "X"
      puts "My shot on #{coordinate} sunk your ship!"
    end
  end

  def computer_shot
    computer_shot_coordinate = @player_board.cells.keys.sample
    if @player_board.cells[computer_shot_coordinate].fired_upon?
      computer_shot
    else
      computer_fire_upon(computer_shot_coordinate)
    end
  end
end
