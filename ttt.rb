# tic tac toe game

# tic tac toe is a game played on a 3x3 board with two players. the first player
# to get 3 squares in a row (up, down, across, or diagonally) is the winner.
# if all 9 squares are full and no player has 3 squares in a row, the game is a
# tie.

# the players are represented by a 'X' or 'O'.
# the players take turns placing their symbol on the board.
# the player picks a square on the board from numbers 1-9
# if the square is already taken, the player must choose again
# the board is redrawn with the player's move included
# the game ends when a player wins or the board is full
# if the board is full and no player has won, the game is a tie

# nouns: board, player, symbol, square, game
# verbs: play, draw, check_win, player_move, occupied?

# Game
class Game
  def initialize
    @turn_count = 1
    @winner = nil
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @board = Board.new(self)
    @current_player = @turn_count.odd? ? @player1 : @player2
  end
  # attr_accessor :turn_count, :winner, :player1, :player2, :board, :current_player
  attr_accessor :turn_count, :winner, :board, :current_player

  # starts the game
  def play
    @board.draw
    handle_input until game_end?
    if @board.check_win?
      @winner = @turn_count.odd? ? @player2 : @player1
      puts "Congratulations #{@winner.name} you win!"
    else
      puts 'The game is a tie!'
    end
    puts 'Would you like to play again? (y/n)'
    input = gets.chomp.downcase
    input.include?('y') ? restart : quit
      
  end

  # ends the game
  def quit
    puts 'Thanks for playing! (Press enter to exit)'
    gets
    exit
  end

  # resets the game
  def restart
    @board = Board.new(self)
    @turn_count = 1
    @winner = nil
    @board.draw
    @current_player = @turn_count.odd? ? @player1 : @player2
    play
  end

  # explains the rules of the game and the actions available to the player
  def help
    puts 'The rules of tic tac toe are as follows:'
    puts 'The first player to get 3 squares in a row (up, down, across, or diagonally) is the winner.'
    puts 'If all 9 squares are full and no player has 3 squares in a row, the game is a tie.'
    puts "The players are represented by a 'X' or 'O' sometimes called 'crosses' and 'knots'."
    puts 'Please enter a number between 1 and 9 to place your symbol on the board. The board is numbered as follows:'
    puts ' 1 | 2 | 3 '
    puts '---+---+---'
    puts ' 4 | 5 | 6 '
    puts '---+---+---'
    puts ' 7 | 8 | 9 '
    puts "Type 'quit'/'q' to end the game, 'restart'/'r' to start a new game, or 'help'/'h' to see this message again."
    puts 'Press enter to continue...'
    # pause until the user presses enter
    gets
  end

  # player move
  def player_move(player_input)
    # reference player input
    position = player_input.to_i - 1
    # check if the position is empty
    if !@board.empty?(position)
      puts 'That position is already taken, please try again:'
      handle_input
    else # place the player's symbol on the board
      @board.fill_square(position, @current_player.symbol)
      @turn_count += 1
      @current_player = @turn_count.odd? ? @player1 : @player2
      @board.draw
    end
  end

  # handles player input
  def handle_input
    puts "#{@current_player.name} you're #{@current_player.symbol}'s, please enter a number between 1 and 9:"
    input = @current_player.take_input
    case input
      # check if the player wants to quit, restart, or get help
    when 'quit' || 'q'
      quit
    when 'restart' || 'r'
      restart
    when 'help' || 'h'
      help
      # check if the player's input is a number between 1 and 9
    when '1'..'9'
      player_move(input)
      # if the input is not valid, ask the player to try again
    else
      puts "That is not a valid input, please try again: (type 'help' for a list of commands)"
      handle_input
    end
  end

  # checks if the game is over
  def game_end?
    return true if @board.check_win? || @board.check_full?

    false
  end
end

# Board class, checks win conditions and empty spaces, draws the board
class Board
  def initialize(game)
    @board = Array.new(9, nil)
    @position = 0
    @game = game
    # set winning combinations
    @winning_combinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # columns
      [0, 4, 8], [2, 4, 6] # diagonals
    ]
  end

  # attr_accessor :board
  attr_reader :position

  def fill_square(position, symbol)
    @board[position] = symbol
  end

  def draw
    system 'clear'
    puts " #{@board[0] || ' '} | #{@board[1] || ' '} | #{@board[2] || ' '} "
    puts '---+---+---'
    puts " #{@board[3] || ' '} | #{@board[4] || ' '} | #{@board[5] || ' '} "
    puts '---+---+---'
    puts " #{@board[6] || ' '} | #{@board[7] || ' '} | #{@board[8] || ' '} "
    puts "The current turn is #{@game.turn_count}"
  end

  def empty?(position)
    position = position.to_i
    @board[position].nil?
  end

  def check_full?
    @board.all? { |square| !square.nil? }
  end

  def check_win?
    # iterate through winning combinations
    @winning_combinations.any? do |a, b, c|
      # check if any of the winning combinations are filled with the same symbol
      !empty?(a) && !empty?(b) && !empty?(c) && @board[a] == @board[b] && @board[b] == @board[c]
    end
  end
end

# Player class holds the player's name and symbol and takes input
class Player
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @input = nil
  end

  # attr_reader :name, :symbol
  attr_reader :name, :symbol

  def take_input
    @input = gets.chomp.downcase
  end
end

game = Game.new
game.play
