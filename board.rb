require_relative 'pieces'

class Board
  attr_reader :rows

  def generate_board
    (2..5).each do |row|
      (0..7).each do |col|
        rows[row][col] = NullPiece.new
      end
    end
  end

  def initialize
    @rows = Array.new(8) { Array.new(8) { Piece.new } }

    generate_board
  end

  def [](pos)
    x,y = pos
    rows[x][y]
  end

  def []=(pos, val)
    x,y = pos
    rows[x][y] = val
  end

  def move_piece(start_pos, end_pos)
    raise "There is no piece there." if !self[start_pos].is_a?(Piece)
    raise "You can't move there." if !self[end_pos].is_a?(NullPiece)

    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
  end
end