# tic tac toe game

# tic tac toe is a game played on a 3x3 board with two players. the first player
# to get 3 squares in a row (up, down, across, or diagonally) is the winner.
# if all 9 squares are full and no player has 3 squares in a row, the game is a
# tie.

# the players are represented by a 'X' or 'O'.
# the players take turns
# the first player to go is chosen at random
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
        @winner = ''
        @player1 = Player.new('Player 1', 'X')
        @player2 = Player.new('Player 2', 'O')
        @board = Board.new()
        @current_player = turn_count.odd? @player1[:name] : @player2[:name]
    end
    # starts the game
    def play()
    end
    # ends the game
    def quit()
    end
    # resets the game
    def restart()
    end
    # explains the rules of the game and the actions available to the player
    def help()
    end
    # player move
    def player_move()
        puts "#{@current_player} you're #{@symbol}'s, please enter a number between 1 and 9:"
        position = handle_input().to_i
        # check if move is valid
        if @board.is_empty?(position)
            # if valid, update board
            @board[position] = @current_player[:symbol]
            # if not valid, prompt player for move again
        else
            puts "That position is already taken, please enter another number:"
            handle_input()

    end
    # handles player input
    def handle_input()
        input = @current_player.take_input()
        case input
        when 'quit'
            quit()            
        when 'restart'
            restart()
        when 'help'
            help()
        when '1'..'9'
            player_move(input)
        else
            puts "That is not a valid input, please try again: (type 'help' for a list of commands)"
            handle_input()
        end
        
    end
    # checks if the game is over
    def game_end?()
    end
end

class Board
    def initialize()
        @board = Array.new(9)
    end
    def draw()
        system 'clear'
        puts " #{@board[1]} | #{@board[2]} | #{@board[3]} "
        puts "---+---+---"
        puts " #{@board[4]} | #{@board[5]} | #{@board[6]} "
        puts "---+---+---"
        puts " #{@board[7]} | #{@board[8]} | #{@board[9]} "
    end
    def is_empty?(position)
        @board[position] == nil
    end
    def check_full()
        @board.none? {|square| is_empty?(square)}
    end
    def check_win()
    end
end


class Player
    def initialize()
        @name = name
        @symbol = symbol
        @input = ''
    end
    def take_input()
        @input = gets.chomp.downcase
    end
end