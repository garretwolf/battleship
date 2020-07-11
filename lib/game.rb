class Game

  def start
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit"

    user_response = gets.chomp.downcase

    if user_response == "p"
      # direct to method to begin setup of game
    elsif user_response == "q"
      p "You have quit the game."
      exit
    else
      p "That is not a valid response. Please try again."
      start
    end
  end
end
