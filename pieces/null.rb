require 'singleton'
require_relative 'piece'

class NullPiece < Piece
  attr_reader :symbol
  include Singleton

  def initialize
    @color = :none
    @symbol = " "
  end

  def empty?
    true
  end

  def moves
    []
  end
end