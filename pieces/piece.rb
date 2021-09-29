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

  def valid_moves
    moves.reject do |move|
      move_into_check?(move)
    end
  end

  def move_into_check?(end_pos)
    start_pos = pos
    board.move_piece!(pos, end_pos)
    check = board.in_check?(color)
    board.move_piece!(end_pos, start_pos)
    check
  end
end