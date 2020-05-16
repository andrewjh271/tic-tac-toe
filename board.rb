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

  def check_for_win
    update_values
    @winning_lines.each_value do |v|
      if v.all?(" #{@player1.marker} ")
        v.map! do |square|
          square[0] = '*'
          square[2] = '*'
        end
        display
        puts "#{@player1.name} wins!"
        return true
      elsif v.all?(" #{@player2.marker} ")
        v.map! do |square|
          square[0] = '*'
          square[2] = '*'
        end
        puts "#{@player2.name} wins!"
        display
        return true
      end
    end
    return false
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

end