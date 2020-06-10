class Board
  def initialize(player1, player2)
    @squares = []
    9.times do |i|
      @squares[i] = " "
    end
    @player1 = player1
    @player2 = player2
    @winning_lines = {
      # indexes for @square
      row1: [0, 1, 2],
      row2: [3, 4, 5],
      row3: [6, 7, 8],
      columnA: [0, 3, 6],
      columnB: [1, 4, 7],
      columnC: [2, 5, 8],
      diag1: [0, 4, 8],
      diag2: [2, 4, 6]
    }
  end

  def display
    # slightly more complicated because I wanted it to match chess notation
    puts
    puts "       |     |     "
    8.downto(0) do |i|
      if i % 3 == 0
        puts "  #{@squares[i+2]}  "
        unless(i == 0)
          print "  _____|_____|_____"
          puts
        end
        puts "       |     |     "
      elsif i % 3 == 1
        print "  #{@squares[i]}  |"
      else
        print "#{(i + 1) / 3}   #{@squares[i-2]}  |"
      end
    end
    puts "    a     b     c  "
    puts
  end

  def mark(player, index)
    return false unless @squares[index] == " "
    @squares[index] = player.marker
    randomize_winning_lines
  end

  def full?
    if @squares.none? { |square| square == " " }
      display
      puts "Stalemate!"
      puts
      return true
    end
    false
  end

  def empty?
    @squares.all? { |square| square == " " }
  end

  def check_for_win
    @winning_lines.each_value do |v|
      if v.all? { |index| @squares[index] == @player1.marker }
        v.each { |index| @squares[index] = @player1.marker.cyan }
        display
        puts "#{@player1.name} wins!".cyan
        puts
        return true
      elsif v.all? { |index| @squares[index] == @player2.marker }
        v.each { |index| @squares[index] = @player2.marker.red }
        display
        puts "#{@player2.name} wins!".red
        puts
        return true
      end
    end
    false
  end

  def one_away_offense(player)
    friendly_marker = (player == @player1) ? @player1.marker : @player2.marker
    @winning_lines.each_value do |v|
      if v.count { |index| @squares[index] == friendly_marker } == 2
        empty_index = v.find { |index| @squares[index] == " "}
        return empty_index if empty_index
      end
    end
    -1
  end

  def one_away_defense(player)
    opposing_marker = (player == @player1) ? @player2.marker : @player1.marker
    @winning_lines.each_value do |v|
      if v.count { |index| @squares[index] == opposing_marker } == 2
        empty_index = v.find { |index| @squares[index] == " "}
        return empty_index if empty_index
      end
    end
    -1
  end

  def best_squares(player)
    friendly_marker = (player == @player1) ? @player1.marker : @player2.marker
    opposing_marker = (player == @player1) ? @player2.marker : @player1.marker
    corners = [0, 2, 6, 8]
    return find_empty_corner if empty? && rand < 0.5
    return 4 if empty? || @squares[4] == " "
    corners.each do |i|
      if @squares[i] == opposing_marker && @squares[opposite(i)] == " "
        return opposite(i)
      elsif @squares[i] == opposing_marker && 
        @squares[opposite(i)] == opposing_marker &&
        @squares.count { |square| square != " " } == 3
        return find_empty_side 
      elsif @squares[i] == friendly_marker &&
        @squares[opposite(i)] == " "
        return opposite(i)
      end
    end
    if corners.all? { |corner| @squares[corner] == " " }
      corners.each do |i|
        if @squares[adjacent(i)[0]] == opposing_marker &&
          @squares[adjacent(i)[1]] == opposing_marker
          return i
        end
      end
    end
    @winning_lines.each_value do |v|
      if @squares[v[0]] == friendly_marker &&
        @squares[v[1]] == " " &&
        @squares[v[2]] == " "
        return v[2]
      elsif @squares[v[0]] == " " &&
        @squares[v[1]] == " " &&
        @squares[v[2]] == friendly_marker
        return v[0]
      end
    end
    empty_corners = corners.select { |i| @squares[i] == " " }
    return empty_corners[rand(empty_corners.length)] unless empty_corners.empty?
    -1
  end

  private

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

  def randomize_winning_lines
    # changes order of @winning_lines hash so iterators will check values in a different order
    temp = @winning_lines.to_a
    temp = temp.sample(temp.length)
    @winning_lines = temp.to_h
  end

end