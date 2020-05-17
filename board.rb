class Board
  def initialize(player1, player2)
    @squares = []
    9.times do |i|
      @squares[i] = "   "
    end
    @player1 = player1
    @player2 = player2
  end

  def display
    # slightly more complicated because I wanted it to match chess notation
    puts
    puts "       |     |     "
    8.downto(0) do |i|
      if i % 3 == 0
        puts " #{@squares[i+2]} "
        unless(i == 0)
          print "  _____|_____|_____"
          puts
        end
        puts "       |     |     "
      elsif i % 3 == 1
        print " #{@squares[i]} |"
      else
        print "#{(i + 1) / 3}  #{@squares[i-2]} |"
      end
    end
    puts "    a     b     c  "
    puts
  end

  def mark(player, index)
    return false unless @squares[index] == "   "
    @squares[index] = " #{player.marker} "
  end

  def full?
    if @squares.none? { |square| square == "   "}
      display
      puts "Stalemate!"
      puts
      return true
    end
  end

  def empty?
    @squares.all? { |square| square == "   "}
  end

  def check_for_win
    update_values
    @winning_lines.each_value do |v|
      if v.all?(" #{@player1.marker} ")
        v.each do |cell|
          target_square = @squares.find_index { |square| square.equal?(cell) }
          @squares[target_square] = "*#{@player1.marker}*".cyan
        end
        display
        puts "#{@player1.name} wins!"
        puts
        return true
      elsif v.all?(" #{@player2.marker} ")
        v.each do |cell|
          target_square = @squares.find_index { |square| square.equal?(cell) }
          @squares[target_square] = "*#{@player2.marker}*".red
        end
        display
        puts "#{@player2.name} wins!"
        puts
        return true
      end
    end
    false
  end

  def one_away_offense(player)
    update_values
    friendly_marker = (player == @player1) ? @player1.marker : @player2.marker
    @winning_lines.each_value do |v|
      num = 0
      v.each do |square|
        num += 1 if square == " #{friendly_marker} "
      end
      if num == 2
        empty_square = v.find_index { |square| square == "   "}
        if empty_square
          target_index = @squares.find_index { |square| v[empty_square].equal?(square) }
          return target_index
        end
      end
    end
    -1
  end

  def one_away_defense(player)
    update_values
    opposing_marker = (player == @player1) ? @player2.marker : @player1.marker
    @winning_lines.each_value do |v|
      num = 0
      v.each do |square|
        num += 1 if square == " #{opposing_marker} "
      end
      if num == 2
        empty_square = v.find_index { |square| square == "   "}
        if empty_square
          target_index = @squares.find_index { |square| v[empty_square].equal?(square) }
          return target_index
        end
      end
    end
    -1
  end

  def best_squares(player)
    update_values
    friendly_marker = (player == @player1) ? @player1.marker : @player2.marker
    opposing_marker = (player == @player1) ? @player2.marker : @player1.marker
    corners = [0, 2, 6, 8]
    return find_empty_corner if empty? && rand < 0.5
    return 4 if empty? || @squares[4] == "   "
    corners.each do |i|
      if @squares[i] == " #{opposing_marker} " && @squares[opposite(i)] == "   "
        return opposite(i)
      elsif @squares[i] == " #{opposing_marker} " && 
        @squares[opposite(i)] == " #{opposing_marker} " &&
        @squares.count { |square| square != "   " } == 3
        return find_empty_side 
      elsif @squares[i] == " #{friendly_marker} " &&
        @squares[opposite(i)] == "   "
        return opposite(i)
      end
    end
    if corners.all? { |corner| @squares[corner] == "   " }
      corners.each do |i|
        if @squares[adjacent(i)[0]] == " #{opposing_marker} " &&
          @squares[adjacent(i)[1]] == " #{opposing_marker} "
          return i
        end
      end
    end
    @winning_lines.each_value do |v|
      if v[0] == " #{friendly_marker} " &&
        v[1] == "   " &&
        v[2] == "   "
        target_square = v[2]
        target_index = @squares.find_index { |square| square.equal?(target_square) }
        return target_index
      elsif v[0] == "   " &&
        v[1] == "   " &&
        v[2] == " #{friendly_marker} "
        target_square = v[0]
        target_index = @squares.find_index { |square| square.equal?(target_square) }
        return target_index
      end
    end
    empty_corner = corners.find { |i| @squares[i] == "   " }
    return empty_corner if empty_corner
    -1
  end

  private

  def update_values
    @winning_lines = {
      row1: [@squares[0], @squares[1], @squares[2]],
      row2: [@squares[3], @squares[4], @squares[5]],
      row3: [@squares[6], @squares[7], @squares[8]],
      columnA: [@squares[0], @squares[3], @squares[6]],
      columnB: [@squares[1], @squares[4], @squares[7]],
      columnC: [@squares[2], @squares[5], @squares[8]],
      diag1: [@squares[0], @squares[4], @squares[8]],
      diag2: [@squares[2], @squares[4], @squares[6]]
    }
  end

  def opposite(i)
    case i
    when 0
      8
    when 8
      0
    when 2
      6
    when 6
      2
    end
  end

  def adjacent(i)
    case i
    when 0
      [1, 3]
    when 6
      [3, 7]
    when 2
      [1, 5]
    when 8
      [5, 7]
    end
  end

  def find_empty_side
    # only called when all four sides are empty
    rand(4) * 2 + 1
  end

  def find_empty_corner
    # only called when all four corners are empty
    rand(4) * 2
  end
end