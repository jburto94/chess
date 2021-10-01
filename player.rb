class Player
  attr_reader :color, :display
  attr_accessor :in_check

  def initialize(color, display, in_check=false)
    @color, @display, @in_check = color, display, in_check
  end

  def make_move
    puts "#{color.to_s}, select a piece to move."
    start_pos = display.move_display
    puts "#{color.to_s}, select a position to move your piece."
    end_pos = display.move_display
    [start_pos, end_pos]
  end
end