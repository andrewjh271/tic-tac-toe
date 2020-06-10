require './lib/board.rb'
require './lib/player.rb'
require './lib/color.rb'

describe Board do

  player1 = Human.new("Player1", "X")
  player2 = Computer.new("Computer1", "0", "difficult")
  subject { board = Board.new(player1, player2) }
  before do
    allow($stdout).to receive(:write)
  end

  describe '#empty?' do
    it 'returns true if board is empty' do
      expect(subject).to be_empty
    end
    it 'returns false if board is not empty' do
      subject.mark(player1, 4)
      expect(subject).not_to be_empty
    end
  end

  describe '#full?' do
    it 'returns true if board is full' do
      9.times { player2.move(subject) }
      expect(subject).to be_full
    end
    it 'returns false if board is not full' do
      8.times { player2.move(subject) }
      expect(subject).not_to be_empty
    end
  end

  describe '#check_for_win' do
    it 'returns true if three of the same mark in a row horizontally' do
      3.times { |i| subject.mark(player1, i) }
      expect(subject.check_for_win).to eq(true)
    end

    it 'returns false if three of different marks in a row horizontally' do
      2.times { |i| subject.mark(player1, i) }
      subject.mark(player2, 3)
      expect(subject.check_for_win).to eq(false)
    end

    it 'returns true if three of the same mark in a row vertically' do
      3.times { |i| subject.mark(player1, i * 3) }
      expect(subject.check_for_win).to eq(true)
    end

    it 'returns true if three of the same mark in a row diagonally' do
      3.times { |i| subject.mark(player1, i * 4) }
      expect(subject.check_for_win).to eq(true)
    end
  end

  describe '#one_away_offense' do
    it 'returns missing index if a player is one away from making row' do
      2.times { |i| subject.mark(player1, i * 8) }
      expect(subject.one_away_offense(player1)).to eq(4)
    end
    it 'returns -1 if a player is not one away from making row' do
      subject.mark(player1, 7)
      subject.mark(player1, 2)
      subject.mark(player1, 3)
      expect(subject.one_away_offense(player1)).to eq(-1)
    end
  end

  describe '#one_away_defense' do
    it 'returns missing index if opponent is one away from making row' do
      2.times { |i| subject.mark(player1, i * 8) }
      expect(subject.one_away_defense(player2)).to eq(4)
    end
    it 'returns -1 if opponent is not one away from making row' do
      subject.mark(player1, 7)
      subject.mark(player1, 2)
      subject.mark(player1, 3)
      expect(subject.one_away_defense(player2)).to eq(-1)
    end
  end

  describe '#best_squares' do
    # unless one_away_offense or one_away_defense
    it 'returns an empty square opposite opponent' do
      subject.mark(player2, 4)
      subject.mark(player1, 0)
      expect(subject.best_squares(player2)).to eq(8)
    end
    it 'otherwise returns a side in case of corner trap' do
      subject.mark(player1, 0)
      subject.mark(player2, 4)
      subject.mark(player1, 8)
      expect(subject.best_squares(player2)).to eq(3) | eq(7) | eq(5) | eq(1)
    end
    it 'otherwise returns square opposite self' do
      subject.mark(player2, 2)
      subject.mark(player1, 4)
      expect(subject.best_squares(player2)).to eq(6)
    end
    it 'otherwise returns corner surrounded by opponent if all corners are empty' do
      subject.mark(player1, 3)
      subject.mark(player2, 4)
      subject.mark(player1, 7)
      expect(subject.best_squares(player2)).to eq(6)
    end
    it 'otherwise chooses corner that could potentially be part of 2 rows' do
      subject.mark(player2, 4)
      subject.mark(player1, 0)
      subject.mark(player2, 8)
      subject.mark(player1, 7)
      expect(subject.best_squares(player2)).to eq(2)
    end
  end
end