require_relative 'board'
require_relative 'player'



print "Enter Player 1's name: "
name = gets.chomp
print "Enter Player 1's mark: "
mark = gets.chomp.chr
player1 = Human.new(name, mark)

print "Enter Player 2's name: "
name = gets.chomp
print "Enter Player 2's mark: "
mark = gets.chomp.chr
player2 = Human.new(name, mark)

board = Board.new(player1, player2)
board.display

loop do
  player1.move(board)
  break if board.check_for_win
  board.display
  player2.move(board)
  break if board.check_for_win
  board.display
end