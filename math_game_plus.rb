require './player'
require './question'

class MathGamePlus

  def initialize
    @freshgame=true
    @theplayers = [Player.new, Player.new]
  
    @theproblem = Question.new

    @currentplayer=0
  end

  def reset_players
    @theplayers.each do |theplayer|
      theplayer.reset_player
    end

    puts "Players Reset"
    puts
  end

  def nextgame
    @theplayers.each do |theplayer|
      theplayer.score = 0
      theplayer.lives = 3
    end
    run_game
  end

  def set_players(name1, name2)
    @theplayers[0].name = name1
    @theplayers[1].name = name2

    puts "Player 1 set to #{name1}"
    puts "Player 2 set to #{name2}"
    puts
  end

  def roll_problem
    @theproblem.generate_question
  end

  def switch_player
    @currentplayer == 0 ? @currentplayer=1 : @currentplayer = 0
  end

  def run_game
    command=""
  
    while command!="quit"
      roll_problem
      puts "it is #{@theplayers[@currentplayer].name}'s turn"
      puts
      @theproblem.print_question
      puts

      command = gets.chomp

      if @theproblem.guess_answer?(command)
        @theplayers[@currentplayer].gain_point
        puts "\033[32mCorrect\033[0m\n"
        puts "========================================="
        puts
        puts "Standings: "
        @theplayers.each do |v|
          v.print_player
        end
       
        puts
        puts
  
        switch_player
      elsif command == "quit"
        break
      else
        @theplayers[@currentplayer].lose_life
        puts "\033[31mIncorrect\033[0m\n"
        @theproblem.print_answer
        puts "========================================="
        puts
        puts "Standings"
        @theplayers.each do |v|
          v.print_player
        end
        puts
        puts
  
        if @theplayers[@currentplayer].is_player_dead?
          puts "#{@theplayers[@currentplayer].name} is dead!"
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
    thewinner = nil
    match_score = 0
    @theplayers.each do |v|
      if v.score>match_score
        thewinner=v
        match_score = v.score
      end
    end

    if thewinner == nil
      puts "+================================="
      puts "||  No one won, everyone is a loser"
      puts "+================================="
      puts
    else

      puts "+================================="
      puts "||  #{thewinner.name} has won with #{thewinner.score} points, they have won #{thewinner.wins} games"
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

    @theplayers.each do |v|
      v.print_player
    end

    rand(2) == 0?@currentplayer=0 : @currentplayer=1

    puts "Coin flip says it's #{@theplayers[@currentplayer].name}'s turn"
  
    run_game
  end
end

thegame = MathGamePlus.new
thegame.start_menu
