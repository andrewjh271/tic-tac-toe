class Player
  attr_accessor :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Human < Player
  def move(board)
    print "Enter coordinates for #{name}'s move: "
    coordinates = gets.chomp
    until(/[abc]/.match(coordinates[0]) &&  /[123]/.match(coordinates[1]))
      print "Enter coordinates for #{name}'s move (e.g., b3): "
      coordinates = gets.chomp
    end
    index = (coordinates[0].ord - 97) + ((coordinates[1].to_i - 1) * 3)
    return if board.mark(self, index)
    puts "That square is already taken. Please enter the coordinates of an empty square."
    move(board)
  end
end

class Computer < Player
  def initialize(name, marker, level)
    super(name, marker)
    @level = level
  end

  def move(board)
    case(@level)
    when('easy')
      move_easy(board)
    when('medium')
      move_medium(board)
    when('difficult')
      move_difficult(board)
    end
  end

  private

  def move_easy(board)
    index = rand(9)
    # returns true if successful
    if board.mark(self, index)
      puts "#{name}: #{convert(index)}"
      return
    end
    move_easy(board)
  end

  def move_medium(board)
    index = board.one_away_offense(self)
    unless(index == -1)
      puts "#{name}: #{convert(index)}"
      board.mark(self, index)
      return
    end
    index = board.one_away_defense(self)
    unless(index == -1)
      puts "#{name}: #{convert(index)}"
      board.mark(self, index)
      return
    end
    if @level == 'medium'
      move_easy(board)
    else
      move_difficult(board, 'continue')
    end
  end

  def move_difficult(board, continue=false)
    unless continue
      move_medium(board)
      return
    end
    index = board.best_squares(self)
    unless(index == -1)
      puts "#{name}: #{convert(index)}"
      board.mark(self, index)
      return
    end
    move_easy(board)
  end

  def convert(index)
    b = (index / 3) + 1
    a = (index - ((b - 1) * 3) + 97).chr
    a + b.to_s
  end
end
