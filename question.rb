class Question
  def initialize
    @num1 = 0
    @num2 = 0
    @text = ""
    @answer = 0
  end

  def generate_question
    roll = rand(5)
    if roll == 0
      generate_nums(500)
      @answer = @num1 + @num2
      @text = "#{@num1} + #{@num2}"
    elsif roll == 1
      generate_nums(500)
      @answer = @num1 - @num2
      @text = "#{@num1} - #{@num2}"
    elsif roll == 2
      generate_nums(100)
      @answer = @num1 * @num2
      @text = "#{@num1} x #{@num2}"
    elsif roll == 3
      generate_nums(100)
      @answer = @num1 / @num2
      @text = "#{@num1} / #{@num2}"
    else
      generate_nums(10)
      @answer = @num1 ** @num2
      @text = "#{@num1} ^ #{@num2}"
    end
  end

  def generate_nums(limit)
    @num1 = 1+ rand(limit)
    @num2 = 1+ rand(limit)
  end

  def guess_answer?(theguess)
    return theguess.to_i == @answer
  end

  def print_answer
    puts "+-------------------------"
    puts "|  The answer was: #{@answer}"
    puts "+-------------------------"
  end

  def print_question
    puts "+-------------------------"
    puts "|  The problem is: #{@text}"
    puts "+-------------------------"
  end
end
