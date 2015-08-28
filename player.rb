class Player
  attr_accessor :name, :score, :lives, :wins
  
  def initialize
    @name = ""
    @score = 0
    @lives = 3
    @wins = 0
  end

  def reset_player
    @name = ""
    @score = 0
    @lives = 3
    @wins = 0
  end

  def lose_life
    @lives -= 1
  end

  def gain_point
    @score += 1
  end

  def make_guess

  end

  def print_player
    puts
    puts "+-------------------------"
    puts "|  Name: #{@name}"
    puts "|  Score: \033[32m#{@score}\033[0m\n"
    puts "|  Lives: \033[31m#{@lives}\033[0m\n"
    puts "|  Wins: #{@wins}"
    puts "+-------------------------"
    puts
  end

  def is_player_dead?
    return @lives == 0
  end
end
