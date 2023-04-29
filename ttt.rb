require 'pry-byebug'
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
    def initialize()
        @turn_count = 1
        @winner = nil
        @player1 = Player.new('Player 1', 'X')
        @player2 = Player.new('Player 2', 'O')
        @board = Board.new()
    end
    # starts the game
    def play()
        @board.draw()
        while !game_end?()
            handle_input()
        end
        if @board.check_win?()
            if @turn_count.odd?
                @winner = @player1
            else
                @winner = @player2
            end
            puts "Congratulations #{@winner} you win!"
        else
            puts "The game is a tie!"
        end
    end
    # ends the game
    def quit()
        puts "Thanks for playing!"
        return        
    end
    # resets the game
    def restart()
        @board = Board.new()
        @turn_count = 1
        @winner = nil
        @board.draw()
        handle_input()        
    end
    # explains the rules of the game and the actions available to the player
    def help()
        puts "The rules of tic tac toe are simple. The first player to get 3 squares in a row (up, down, across, or diagonally) is the winner. If all 9 squares are full and no player has 3 squares in a row, the game is a tie."
        puts "The players are represented by a 'X' or 'O'. Please enter a number between 1 and 9 to place your symbol on the board. The board is numbered as follows:"
        puts " 1 | 2 | 3 "
        puts "---+---+---"
        puts " 4 | 5 | 6 "
        puts "---+---+---"
        puts " 7 | 8 | 9 "
        puts "Type 'quit' to end the game, 'restart' to start a new game, or 'help' to see this message again."
        # pause until the user presses enter
        gets        
    end
    # player move
    def player_move(player_input)
        # reference player input
        position = player_input.to_i - 1
        if @turn_count.odd?
            @board.position(position, @player1.symbol)
            @turn_count += 1
        else
            @board.position(position, @player2.symbol)
            @turn_count += 1
        end
        @board.draw()
    end

    # handles player input
    def handle_input()
        # check current player
        if @turn_count.odd?
            puts "#{@player1.name} you're #{@player1.symbol}'s, please enter a number between 1 and 9:"
            input = @player1.take_input()
        else
            puts "#{@player2.name} you're #{@player2.symbol}'s, please enter a number between 1 and 9:"
            input = @player2.take_input()
        end
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
        if @board.check_win?() || @board.check_full?()
            return true
        else
            return false
        end
    end
end

class Board
    def initialize()
        @board = Array.new(9, nil)
        @position = 0
    end
    # attr_accessor :board
    def position(position, symbol)
        if is_empty?(position)
            @board[position] = symbol
        else
            puts "That position is already taken, please enter another number:"
            handle_input()
        end
    end
    
    def draw()
        system 'clear'
        puts " #{@board[0] || ' '} | #{@board[1] || ' '} | #{@board[2] || ' '} "
        puts "---+---+---"
        puts " #{@board[3] || ' '} | #{@board[4] || ' '} | #{@board[5] || ' '} "
        puts "---+---+---"
        puts " #{@board[6] || ' '} | #{@board[7] || ' '} | #{@board[8] || ' '} "
    end
    def is_empty?(position)
        position = position.to_i
        @board[position].nil?
    end
    def check_full?()
        @board.none? {|square| is_empty?(square)}
    end
    def check_win?()
        # set winning combinations
        winning_combinations = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], # rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], # columns
            [0, 4, 8], [2, 4, 6] # diagonals
        ]
        # iterate through winning combinations
        winning_combinations.any? do |a, b, c|
            # check if any of the winning combinations are filled with the same symbol
            !is_empty?(a) && @board[a] == @board[b] && @board[b] == @board[c]
        end
    end
end


class Player
    def initialize(name, symbol)
        @name = name
        @symbol = symbol
        @input = 1
    end
    # attr_reader :name, :symbol
    def name()
        @name
    end
    def symbol()
        @symbol
    end
    def take_input()
        @input = gets.chomp.downcase
    end
end

game = Game.new()
game.play()