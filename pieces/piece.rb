require_relative '../board'

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

  end

  private
  def move_into_check?(end_pos)

  end
end

class Rook < Piece

end

class Bishop < Piece

end

class Queen < Piece

end

class Knight < Piece

end

class King < Piece

end

class Pawn < Piece

end

class NullPiece < Piece
  
end