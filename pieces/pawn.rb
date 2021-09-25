require_relative 'piece'
require 'colorize'

class Pawn < Piece
  def symbol
    '︎♟︎'.colorize(color)
  end

  def moves
    []
  end

  private
  def at_start_row?
    return true if color == :black && board.rows[1].include?(self)
    return true if color == :white && board.rows[6].include?(self)
    return false
  end

  def forward_dir
    color == :white ? 1 : -1
  end

  def forward_steps
    x,y = pos
    move_pos = [x + forward_dir, y]
    moves << move_pos if board[move_pos].empty? && board[move_pos].valid_pos?

    if at_start_row?
      moves_pos = [x + (forward_dir * 2), y]
      moves << move_pos if board[move_pos].empty? && board[move_pos].valid_pos?
    end
  end

  def side_attacks
    x,y = pos
    sides = [
      [x + forward_dir, y - 1],
      [x + forward_dir, y + 1]
    ]

    sides.select! { |side| board[side].valid_pos? }

    sides.each { |side| moves << side if board[side].color != color && !board[side].empty?}
  end
end