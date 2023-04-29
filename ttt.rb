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
        @current_player = @turn_count.odd? ? @player1 : @player2
    end
    # starts the game
    def play()
        while !game_end?()
            @board.draw()
            handle_input()
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
        @current_player = @turn_count.odd? ? @player1 : @player2
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
        
    end
    # player move
    def player_move()
        # reference player input
        position = @current_player[:input].to_i - 1
        # check if move is valid
        if @board.is_empty?(position)
            # if valid, update board
            @board[position] = @current_player[:symbol]
            # if not valid, prompt player for move again
        else
            puts "That position is already taken, please enter another number:"
            handle_input()
        end
        @turn_count += 1
        @current_player = @turn_count.odd? ? @player1 : @player2
    end

    # handles player input
    def handle_input()
        puts "#{@current_player[:name]} you're #{@current_player[:symbol]}'s, please enter a number between 1 and 9:"
        input = @current_player.take_input()
        case input
        when 'quit'
            quit()            
        when 'restart'
            restart()
        when 'help'
            help()
        when '1'..'9'
            player_move()
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
    end
    def draw()
        system 'clear'
        puts " #{@board[1] || ' '} | #{@board[2] || ' '} | #{@board[3] || ' '} "
        puts "---+---+---"
        puts " #{@board[4] || ' '} | #{@board[5] || ' '} | #{@board[6] || ' '} "
        puts "---+---+---"
        puts " #{@board[7] || ' '} | #{@board[8] || ' '} | #{@board[9] || ' '} "
    end
    def is_empty?(position)
        @board[position].nil?
    end
    def check_full?()
        @board.none? {|position| is_empty?(position)}
    end
    def check_win?()
        # return true if the board contains a winning combination of symbols that are not nil
        # check rows
        if @board[0] == @board[1] && @board[1] == @board[2] && !is_empty?(0)
            return true
        elsif @board[3] == @board[4] && @board[4] == @board[5] && !is_empty?(3)
            return true
        elsif @board[6] == @board[7] && @board[7] == @board[8] && !is_empty?(6)
            return true
        # check columns
        elsif @board[0] == @board[3] && @board[3] == @board[6] && !is_empty?(0)
            return true
        elsif @board[1] == @board[4] && @board[4] == @board[7] && !is_empty?(1)
            return true
        elsif @board[2] == @board[5] && @board[5] == @board[8] && !is_empty?(2)
            return true
        # check diagonals
        elsif @board[0] == @board[4] && @board[4] == @board[8] && !is_empty?(0)
            return true
        elsif @board[2] == @board[4] && @board[4] == @board[6] && !is_empty?(2)
            return true
        else
            return false
        end
    end
end


class Player
    def initialize(name, symbol)
        @name = name
        @symbol = symbol
        @input = ''
    end
    def take_input()
        @input = gets.chomp.downcase
    end
end

game = Game.new()
game.play()