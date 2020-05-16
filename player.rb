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
    coordinate = gets.chomp
    until(/[abc]/.match(coordinate[0]) &&  /[123]/.match(coordinate[1]))
      print "Enter coordinates for #{name}'s move (eg. b3): "
      coordinate = gets.chomp
    end
    index = (coordinate[0].ord - 97) + ((coordinate[1].to_i - 1) * 3)
    return if board.mark(self, index)
    puts "That square is already taken. Please enter the coordinates of an empty square."
    move(board)
  end
end