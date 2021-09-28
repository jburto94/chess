require_relative 'pieces'

class Board
  attr_reader :rows

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
    x,y = pos
    x >= 0 && y >= 0 && x <= 7 && y <= 7
  end

  def checkmate?(color)
    if in_check?(color)
      rows.each do |row|
        row.each do |piece|
          return false if piece.valid_moves.length > 0
        end
      end
      return true
    end
  end

  def in_check?(color)
    opponent_color = color == :white ? :black : :white
    rows.each do |row|
      row.each do |piece|
        if piece.color == opponent_color
          return true if piece.valid_moves.include?(find_king(color))
        end
      end
    end
    false
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