require_relative 'piece'
require 'colorize'

class Rook < Piece
  include Slideable

  def symbol
    '♜'.colorize(color)
  end

  private
  def move_dirs
    horizontal_dirs
  end
end