require 'colorize'

class Piece
  attr_reader :board, :color
  attr_accessor :pos

  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
  end

  def to_s
    " #{symbol} "
  end

  def empty?
    false
  end

  def symbol
    raise NotImplementedError
  end

  def dup_piece(piece_pos=pos)
    self.class.new(color, board, piece_pos)
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    return false if !board.in_check?(color)
    board.test_move(pos, end_pos)
  end
end