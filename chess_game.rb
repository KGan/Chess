require_relative 'chess_board.rb'
require_relative 'chess_piece.rb'
require_relative 'chess_specific.rb'
require_relative 'chess_player.rb'
require_relative 'exception_names.rb'

require 'colorize'
require 'io/console'

class Game
  def initialize(player1, player2)
    @players = [player1, player2]
    @message = "Welcome! This is the chess chess chess"
  end

  def move_into_check?(start_p, end_p, mycolor)
    duped_board = @board.deep_dup
    duped_board.move(start_p, end_p, mycolor)
    duped_board.in_check?(mycolor)
  end

  def run
    @board = Board.new
    turns = 0
    while !checkmate?
      player = @players[turns%2]
      @message = "#{player.name}'s turn to move"
      display
      move = player.get_move(@board)

      if move.first == 'save'
        save_game
      elsif move.first == 'load'
        load_game
      end

      if move_into_check?(move.first, move.last, player.color)
        @message = "Can't move yourself into check!"
      else
        @board.move(move.first, move.last, player.color)
        if @board.in_check?(player.color)
          @message = 'Check!'
          display
        end
        turns += 1
      end
    end
  end

  def checkmate?
    false
  end

  def display
    @board.display(@message)
  end

  def save_game
    puts "what filename do you want to save as?"
    filename = gets.chomp
    if filename.length < 1
      filename = 'chess'
    end
    filename += '.yml'

    File.write()
  end

  def load_game

  end
end

class History
  def initialize
    @history = []
  end

  def record(start_p, end_p)
    @history << [start_p, end_p]
  end

  def show_history
    puts @history
  end

end
