module Stepable
  def moves
    moves = []

    move_diffs.each do |x,y|
      curr_x, curr_y = pos
      new_pos = [curr_x + x, curr_y + y]

      next unless baord.valid_pos?(new_pos)
      
      moves << new_pos if board[new_pos].empty? || board[new_pos].color != color
    end

    moves
  end

  private
  def move_diffs
    raise NotImplementedError
  end
end