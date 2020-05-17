require_relative 'board'
require_relative 'player'
require 'pry'

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
  print "Enter #{name1}'s mark (e.g. X): "
  mark1 = gets.chomp.chr
  print "Choose the Computer's difficulty level (Easy / Medium / Difficult): "
  level = gets.chomp.chr.downcase
  until level == 'e' || level == 'm' || level == 'd'
    puts "Not a valid answer."
    print "Choose the Computer's difficulty level (Easy / Medium / Difficult): "
    level = gets.chomp.chr.downcase
  end
  case level
  when 'e'
    player1 = Computer.new(name1, mark1, 'easy')
  when 'm'
    player1 = Computer.new(name1, mark1, 'medium')
  when 'd'
    player1 = Computer.new(name1, mark1, 'difficult')
  end
else
  print "Enter Player 1's name: "
  name1 = gets.chomp
  print "Enter #{name1}'s' mark (e.g., X): "
  mark1 = gets.chomp.chr 
  player1 = Human.new(name1, mark1)
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
  print "Enter #{name2}'s mark (e.g., 0): "
  mark2 = gets.chomp.chr
  while mark2 == mark1
    puts "Can't choose the same mark!"
    print "Enter #{name2}'s mark: "
    mark2 = gets.chomp.chr
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
    player2 = Computer.new(name2, mark2, 'easy')
  when 'm'
    player2 = Computer.new(name2, mark2, 'medium')
  when 'd'
    player2 = Computer.new(name2, mark2, 'difficult')
  end
else
  print "Enter Player 2's name: "
  name2 = gets.chomp
  while name2 == name1
    puts "Can't choose the same name!"
    print "Enter Player 2's name: "
    name2 = gets.chomp
  end
  print "Enter #{name2}'s' mark (e.g., 0): "
  mark2 = gets.chomp.chr 
  while mark2 == mark1
    puts "Can't choose the same mark!"
    print "Enter #{name2}'s mark: "
    mark2 = gets.chomp.chr
  end
  player2 = Human.new(name2, mark2)
end

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