require './lib/player.rb'

describe Human do
  describe '#move' do
    subject { Human.new("Player1", "X") }
    before do
      @board = double(:board)
      allow($stdout).to receive(:write)
    end

    it 'calls Board#mark(self, 1) for user input b1' do
      allow(subject).to receive(:gets).and_return('b1')
      expect(@board).to receive(:mark).with(subject, 1).and_return(true)
      subject.move(@board)
    end
    it 'calls Board#mark(self, 8) for user input c3' do
      allow(subject).to receive(:gets).and_return('c3')
      expect(@board).to receive(:mark).with(subject, 8).and_return(true)
      subject.move(@board)
    end
    it 'does not accept invalid input' do
      allow(subject).to receive(:gets).and_return('a4', 'a2')
      expect(@board).to receive(:mark).with(subject, 3).and_return(true)
      expect { subject.move(@board) }.to output(
        "Enter coordinates for Player1's move: " \
        "Enter coordinates for Player1's move (e.g., b3): "
      ).to_stdout
    end
    it 'does not accept an occupied square' do
      allow(subject).to receive(:gets).and_return('a3', 'c2')
      expect(@board).to receive(:mark).with(subject, 6).and_return(false)
      expect(@board).to receive(:mark).with(subject, 5).and_return(true)
      expect { subject.move(@board) }.to output(
        "Enter coordinates for Player1's move: " \
        "That square is already taken. Please enter the coordinates of an empty square.\n" \
        "Enter coordinates for Player1's move: "
      ).to_stdout
    end
  end
end

describe Computer do
  subject { Computer.new('Player1', 'X', "#{level}") }

  describe '#move' do
    let(:level) { 'difficult' }
    it 'calls Board#move_difficult when instance variable @level == "difficult" ' do
      board = double(:board)
      expect(subject).to receive(:move_difficult)
      subject.move(board)
    end
  end

  describe '#move' do
    let(:level) { 'medium' }
    it 'calls Board#move_medium when instance variable @level == "difficult" ' do
      board = double(:board)
      expect(subject).to receive(:move_medium)
      subject.move(board)
    end
  end
end
