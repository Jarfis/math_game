@freshgame=true
@theplayers = {
  player1: {
    name: "",
    score: 0,
    lives: 3,
    wins: 0
  },

  player2: {
    name: "",
    score: 0,
    lives: 3,
    wins: 0
  }
}

@theproblem = {
  text: "",
  num1: 0,
  num2: 0,
  answer: 0
}

@currentplayer = :player1
def reset_players
  @theplayers.each do |k, theplayer|
    theplayer[:name] = ""
    theplayer[:score] = 0
    theplayer[:lives]=3
    theplayer[:wins]=0
  end

  puts "Players Reset"
  puts
end

def nextgame
  @theplayers.each do |k, theplayer|
    theplayer[:score] = 0
    theplayer[:lives]=3
  end
  run_game
end

def set_players(name1, name2)
  @theplayers[:player1][:name] = name1
  @theplayers[:player2][:name] = name2

  puts "Player 1 set to #{name1}"
  puts "Player 2 set to #{name2}"
  puts
end

def generate_addition
  @theproblem[:num1] = rand(500)
  @theproblem[:num2] = rand(500)
  @theproblem[:text] = "#{@theproblem[:num1]} + #{@theproblem[:num2]}"
  @theproblem[:answer] = @theproblem[:num1] + @theproblem[:num2]
end

def generate_multiplication
  @theproblem[:num1] = rand(500)
  @theproblem[:num2] = rand(500)
  @theproblem[:text] = "#{@theproblem[:num1]} x #{@theproblem[:num2]}"
  @theproblem[:answer] = @theproblem[:num1] * @theproblem[:num2]
end

def generate_division
  @theproblem[:num1] = rand(500)
  @theproblem[:num2] = rand(500)
  @theproblem[:text] = "#{@theproblem[:num1]} / #{@theproblem[:num2]}"
  @theproblem[:answer] = @theproblem[:num1] / @theproblem[:num2]
end

def generate_subtraction
  @theproblem[:num1] = rand(500)
  @theproblem[:num2] = rand(500)
  @theproblem[:text] = "#{@theproblem[:num1]} - #{@theproblem[:num2]}"
  @theproblem[:answer] = @theproblem[:num1] - @theproblem[:num2]
end

def generate_exponent
  @theproblem[:num1] = rand(10)
  @theproblem[:num2] = rand(10)
  @theproblem[:text] = "#{@theproblem[:num1]} ^ #{@theproblem[:num2]}"
  @theproblem[:answer] = @theproblem[:num1] ** @theproblem[:num2]
end

def roll_problem
  theroll=rand(5)

  if theroll == 0
    generate_addition
  elsif theroll == 1
    generate_subtraction
  elsif theroll == 2
    generate_division
  elsif theroll == 3
    generate_multiplication
  else
    generate_exponent
  end
end

def guess_answer(guess)
  return @theproblem[:answer]==guess.to_i
end

def switch_player
  @currentplayer == :player1 ? @currentplayer=:player2 : @currentplayer = :player1
end

def print_player(theplayer)
  puts "  ================================="
  puts "||Name: #{theplayer[:name]}"
  puts "||    Score: \033[32m#{theplayer[:score]}\033[0m\n"
  puts "||    Lives: \033[31m#{theplayer[:lives]}\033[0m\n"
  puts "||    Wins: #{theplayer[:wins]}"
  puts "  ================================="
  puts
end

def run_game
  command=""
  
  while command!="quit"
    roll_problem
    puts "it is #{@theplayers[@currentplayer][:name]}'s turn"
    puts
    puts "  ================================="
    puts "||The problem is: #{@theproblem[:text]}"
    puts "  ================================="
    puts

    command = gets.chomp

    if guess_answer(command)
      @theplayers[@currentplayer][:score]+=1
      puts "\033[32mCorrect\033[0m\n"
      puts "========================================="
      puts
      puts "Standings: "
      @theplayers.each do |k,v|
        print_player(v)
      end
     
      puts
      puts

      switch_player
    elsif command == "quit"
      break
    else
      @theplayers[@currentplayer][:lives]-=1
      puts "\033[31mIncorrect\033[0m\n"
      puts "the answer was #{@theproblem[:answer]}"
      puts "========================================="
      puts
      puts "Standings"
      @theplayers.each do |k,v|
        print_player(v)
      end
      puts
      puts

      if @theplayers[@currentplayer][:lives] == 0
        puts "#{@theplayers[@currentplayer][:name]} is dead!"
        break
      else
        switch_player
      end
    end
  end

  end_game
end

def start_menu
  command = ""

  while command.downcase != "quit" && command.downcase != "new game" && command.downcase != "next game"
    puts "+================================="
    if @freshgame
      puts "||Choose an option: New Game, Quit"
    else
      puts "||Choose an option: New Game, Next Game, Quit"
    end
    puts "+================================="
    puts
    command = gets.chomp

    if command.downcase == "new game"
      @freshgame = false
    end

  end

  if command.downcase == "next game"
    nextgame
  elsif command.downcase == "new game"
    reset_players
    start_game
  end
end

def end_game
  thewinner=""
  score = 0
  @theplayers.each do |k,v|
    if v[:score]>score
      thewinner=k
      score = v[:score]
    end
  end

  if thewinner == ""
    puts "+================================="
    puts "No one won, everyone is a loser"
    puts "+================================="
    puts
  else

    puts "+================================="
    puts "#{@theplayers[thewinner][:name]} has won with #{@theplayers[thewinner][:score]} points, they have won #{@theplayers[thewinner][:wins]} games"
    puts "+================================="
    puts
  end

  start_menu
end

def start_game
  puts "Players, please enter your names"
  print "Player 1: "
  p1 = gets.chomp
  print "Player 2: "
  p2 = gets.chomp
  set_players(p1, p2)
  puts

  @theplayers.each do |k,v|
    print_player(v)
  end

  rand(2) == 0?@currentplayer=:player1 : @currentplayer=:player2;

  puts "Coin flip says it's #{@theplayers[@currentplayer][:name]}'s turn"
  
  run_game
end

start_menu
