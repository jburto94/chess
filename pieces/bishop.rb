require_relative 'piece'
require 'colorize'

class Bishop < Piece
  include Slideable

  def symbol
    '♝'.colorize(color)
  end

  private
  def move_dirs
    diagonal_dirs
  end
end