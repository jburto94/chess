require_relative 'piece'
require 'colorize'

class Queen < Piece
  include Slideable

  def symbol
    '♛'.colorize(color)
  end

  private
  def move_dirs
    diagonal_dirs + horizontal_dirs
  end
end