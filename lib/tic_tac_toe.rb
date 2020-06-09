require_relative 'board'
require_relative 'player'
require_relative 'color'
# require 'pry'

print "Is Player 1 a Human or Computer? "
choice = gets.chomp.chr.downcase
until choice == 'h' || choice == 'c'
  puts "Not a valid answer."
  print "Is Player 1 a Human or Computer? "
  choice = gets.chomp.chr.downcase
end
if choice == 'c'
  print "Enter the Computer's name: "
  name1 = gets.chomp
  print "Enter #{name1}'s marker (e.g. X): "
  marker1 = gets.chomp.chr
  print "Choose the Computer's difficulty level (Easy / Medium / Difficult): "
  level = gets.chomp.chr.downcase
  until level == 'e' || level == 'm' || level == 'd'
    puts "Not a valid answer."
    print "Choose the Computer's difficulty level (Easy / Medium / Difficult): "
    level = gets.chomp.chr.downcase
  end
  case level
  when 'e'
    player1 = Computer.new(name1, marker1, 'easy')
  when 'm'
    player1 = Computer.new(name1, marker1, 'medium')
  when 'd'
    player1 = Computer.new(name1, marker1, 'difficult')
  end
else
  print "Enter Player 1's name: "
  name1 = gets.chomp
  print "Enter #{name1}'s' marker (e.g., X): "
  marker1 = gets.chomp.chr 
  player1 = Human.new(name1, marker1)
end

print "Is Player 2 a Human or Computer? "
choice = gets.chomp.chr.downcase
until choice == 'h' || choice == 'c'
  puts "Not a valid answer."
  print "Is Player 2 a Human or Computer? "
  choice = gets.chomp.chr.downcase
end
if choice == 'c'
  print "Enter the Computer's name: "
  name2 = gets.chomp
  while name2 == name1
    puts "Can't choose the same name!"
    print "Enter the Computer's name: "
    name2 = gets.chomp
  end
  print "Enter #{name2}'s marker (e.g., 0): "
  marker2 = gets.chomp.chr
  while marker2 == marker1
    puts "#{marker1} has already been chosen!"
    print "Enter #{name2}'s marker: "
    marker2 = gets.chomp.chr
  end
  print "Choose the Computer's difficulty level (Easy / Medium / Difficult): "
  level = gets.chomp.chr.downcase
  until level == 'e' || level == 'm' || level == 'd'
    puts "Not a valid answer."
    print "Choose the Computer's difficulty level (Easy / Medium / Difficult): "
    level = gets.chomp.chr.downcase
  end
  case level
  when 'e'
    player2 = Computer.new(name2, marker2, 'easy')
  when 'm'
    player2 = Computer.new(name2, marker2, 'medium')
  when 'd'
    player2 = Computer.new(name2, marker2, 'difficult')
  end
else
  print "Enter Player 2's name: "
  name2 = gets.chomp
  while name2 == name1
    puts "Can't choose the same name!"
    print "Enter Player 2's name: "
    name2 = gets.chomp
  end
  print "Enter #{name2}'s' marker (e.g., 0): "
  marker2 = gets.chomp.chr 
  while marker2 == marker1
    puts "#{marker1} has already been chosen!"
    print "Enter #{name2}'s marker: "
    marker2 = gets.chomp.chr
  end
  player2 = Human.new(name2, marker2)
end

# useful for testing...
# player1 = Human.new("Player1", "X")
# player1 = Computer.new("Computer1", "X", "difficult")
# player2 = Human.new("Player2", "0")
# player2 = Computer.new("Computer2", "0", "difficult")

board = Board.new(player1, player2)
puts
puts "*** #{player1.name} vs #{player2.name} ***"
board.display

loop do
  player1.move(board)
  break if board.check_for_win || board.full?
  board.display
  player2.move(board)
  break if board.check_for_win || board.full?
  board.display
end