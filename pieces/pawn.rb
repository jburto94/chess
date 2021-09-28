require_relative 'piece'

class Pawn < Piece
  def symbol
    '︎♟︎'.colorize(color)
  end

  def valid_moves
    moves = forward_steps
    moves += side_attacks
  end

  private
  def at_start_row?
    return true if color == :black && board.rows[1].include?(self)
    return true if color == :white && board.rows[6].include?(self)
    return false
  end

  def forward_dir
    color == :black ? 1 : -1
  end

  def forward_steps
    moves = []
    x,y = pos
    move_pos = [x + forward_dir, y]
    moves << move_pos if board[move_pos].empty? && board.valid_pos?(move_pos)

    if at_start_row?
      move_pos = [x + (forward_dir * 2), y]
      moves << move_pos if board[move_pos].empty? && board.valid_pos?(move_pos)
    end

    moves
  end

  def side_attacks
    moves = []
    x,y = pos
    sides = [
      [x + forward_dir, y - 1],
      [x + forward_dir, y + 1]
    ]

    sides.select! { |side| board.valid_pos?(side) }

    sides.each { |side| moves << side if board[side].color != color && !board[side].empty?}

    moves
  end
end