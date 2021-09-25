require_relative 'piece'
require 'colorize'

class Knight < Piece
  include Stepable

  def symbol
    '♞'.colorize(color)
  end

  def move_diffs
    [
      [2,1],
      [2,-1],
      [1,2],
      [1,-2],
      [-2,1],
      [-2,-1],
      [-1,2],
      [-1,-2]
    ]
  end
end