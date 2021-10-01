require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    (0..7).each do |row|
      (0..7).each do |col|
        tile_color = (row + col) % 2 == 0 ? :light_black : :light_white
        tile_color = :light_magenta if cursor.cursor_pos == [row, col]
        piece_symbol = board[[row,col]].symbol
        print " #{ piece_symbol } ".colorize(:background => tile_color)
      end
      puts
    end
  end

  def move_display
    loop do
      render
      selection = cursor.get_input
      system("clear")
      return selection if selection != nil
    end
  end
end