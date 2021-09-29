require_relative 'piece'

class Pawn < Piece
  def symbol
    '︎♟︎'.colorize(color)
  end

  def moves
    forward_steps + side_attacks
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
    forward_moves = []
    x,y = pos
    move_pos = [x + forward_dir, y]
    forward_moves << move_pos if board[move_pos].empty? && board.valid_pos?(move_pos)

    if at_start_row?
      move_pos = [x + (forward_dir * 2), y]
      forward_moves << move_pos if board[move_pos].empty? && board.valid_pos?(move_pos)
    end

    forward_moves
  end

  def side_attacks
    side_moves = []
    x,y = pos
    sides = [
      [x + forward_dir, y - 1],
      [x + forward_dir, y + 1]
    ]

    sides.select! { |side| board.valid_pos?(side) }

    sides.each { |side| side_moves << side if board[side].color != color && !board[side].empty?}

    side_moves
  end
end