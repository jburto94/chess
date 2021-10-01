require_relative 'pieces'

class Board
  attr_accessor :rows

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
    raise ArgumentError.new("You must select a piece to move.") if self[start_pos].is_a?(Piece) == false
    raise ArgumentError.new("Invalid move.") if self[end_pos].color == self[start_pos].color

    if self[start_pos].valid_moves.include?(end_pos)
      self[end_pos] = self[start_pos]
      self[end_pos].pos = end_pos
      self[start_pos] = NullPiece.instance
    else
      raise ArgumentError.new("Invalid move.")
    end
  end

  def test_move(start_pos, end_pos)
    return true if self[start_pos].is_a?(NullPiece)
    piece = self[start_pos]
    temp_start = piece.class.new(piece.color, self, piece.pos)
    temp_end = self[end_pos].is_a?(NullPiece) ?
      NullPiece.instance :
      self[end_pos].class.new(self[end_pos].color, self, self[end_pos].pos)

    self[end_pos] = temp_start.class.new(temp_start.color, self, end_pos)
    self[start_pos] = NullPiece.instance

    break_check = self.in_check?(temp_start.color)
    self[end_pos] = temp_end.is_a?(NullPiece) ? NullPiece.instance : temp_end.class.new(temp_end.color, self, temp_end.pos)
    self[start_pos] = temp_start.class.new(temp_start.color, self, temp_start.pos)
    break_check
  end

  

  def valid_pos?(pos)
    x,y = pos
    x >= 0 && y >= 0 && x <= 7 && y <= 7
  end

  def checkmate?(color)
    in_check?(color) && pieces(color).all? { |piece| piece.valid_moves.empty? }
  end

  def in_check?(color)
    opponent_color = color == :white ? :black : :white
    pieces(opponent_color).any? { |piece| piece.moves.include?(find_king(color)) }
  end

  def pieces(color)
    rows.flatten.select { |piece| piece.color == color }
  end

  def find_king(color)
    rows.each do |row|
      row.each do |piece|
        return piece.pos if piece.is_a?(King) && piece.color == color
      end
    end
  end

  protected
  def generate_name_pieces
    name_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    (0..7).each do |col|
      rows[0][col] = name_pieces[col].new(:black, self, [0,col])
      rows[7][col] = name_pieces[col].new(:white, self, [7,col])
    end
  end

  def generate_pawns
    (0..7).each do |col|
      rows[1][col] = Pawn.new(:black, self, [1,col])
      rows[6][col] = Pawn.new(:white, self, [6,col])
    end
  end

  def generate_empty_spaces
    (2..5).each do |row|
      (0..7).each do |col|
        rows[row][col] = NullPiece.instance
      end
    end
  end

  def generate_board
    generate_name_pieces
    generate_pawns
    generate_empty_spaces
  end
end