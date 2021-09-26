require_relative 'pieces'

class Board
  attr_reader :rows

  def generate_board
    (2..5).each do |row|
      (0..7).each do |col|
        rows[row][col] = NullPiece.instance
      end
    end
  end

  def initialize
    @rows = Array.new(8) { Array.new(8) }

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
    raise "There is no piece there." if self[start_pos].is_a?(Piece) == false
    raise "You can't move there." if self[end_pos].is_a?(NullPiece) == false

    if self[start_pos].valid_moves.include?(end_pos)
      self[end_pos] = self[start_pos]
      self[end_pos].pos = end_pos
      self[start_pos] = NullPiece.instance
    else
      raise "That is not a valid move for that piece"
    end
  end

  def valid_pos?(pos)
    self[pos]
  end
end