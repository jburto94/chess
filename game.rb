require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game
  attr_reader :board, :display, :player1, :player2
  attr_accessor :current_player

  def initialize
    @board = Board.new
    @display = Display.new(board)
    @player1 = Player.new(:white, display)
    @player2 = Player.new(:black, display)
    @current_player = player1
  end

  def play
    until board.checkmate?(current_player.color) do
      current_player.in_check = true if board.in_check?(current_player.color)
      display.render
      begin
        moves = current_player.make_move
        start_pos, end_pos = moves
        if current_player.color != board[start_pos].color
          raise ArgumentError.new("You must move team's your piece") 
        end
        board.move_piece(start_pos, end_pos)
      rescue ArgumentError => e
        puts e.message
        retry
      end
      self.swap_turn
      opponent_color = current_player.color == :white ? :black : :white
      notify_check if board.in_check?(current_player.color)
      break if board.checkmate?(opponent_color)
    end

    display.render
    notify_players
  end

  def notify_players
    swap_turn
    puts "Checkmate! #{current_player.color.capitalize} is the winner!"
  end

  def notify_check
    puts "Check! #{current_player.color.capitalize} must move out of check."
  end

  def swap_turn
    if self.current_player == player1
      self.current_player = player2
    else
      self.current_player = player1
    end
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new

  game.play
end