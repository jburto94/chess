module Slideable
  HORIZONTAL_DIRS = [
    [0,1],
    [0,-1],
    [1,0],
    [-1,0]
  ]

  DIAGONAL_DIRS = [
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
  ]

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    moves = []

    move_dirs.each { |x,y| moves += grow_unblocked_moves_in_dir(x,y) }

    moves
  end

  private
  def move_dirs
    raise NotImplementedError
  end

  def grow_unblocked_moves_in_dir(x,y)
    curr_x, curr_y = pos
    moves = []

    loop do
      curr_x, curr_y = curr_x + x, curr_y + y
      pos = [curr_x, curr_y]

      break unless board.valid_pos?(pos)

      if board[pos].empty?
        moves << pos
      else
        moves << pos if board[pos].color != color
      end

    moves
  end
end