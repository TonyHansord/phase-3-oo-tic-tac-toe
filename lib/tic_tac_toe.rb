class TicTacToe 

    attr_accessor :board

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5], # Middle row
        [6,7,8], # Bottom row
        [0,3,6], # Left column
        [1,4,7], # Middle column
        [2,5,8], # Right column
        [0,4,8], # Left diagonal
        [2,4,6]  # Right diagonal
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
     return input.to_i - 1
    end


    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        if board[index] == "X" || board[index] == "O"
            return true
        else
            return false
        end
    end

    def valid_move?(index)
        if index.between?(0,8) && !position_taken?(index)
            return true
        else
            return false
        end
    end

    def turn_count
        @board.reduce(0) do |count, space|
            if space == "X" || space == "O"
                count += 1
            end
            count
        end
    end

    def current_player
        if turn_count.even? 
            return "X"
        else 
            return "O"
        end
    end

    def turn
        position = gets.chomp
        player = current_player()
        index = input_to_index(position)
        isValid = valid_move?(index)

        while !isValid
            position = gets.chomp
            index = input_to_index(position)
            isValid = valid_move?(index)
        end

        move(index, player)
        display_board()
    end

    def won?

        WIN_COMBINATIONS.each do |win_combo|
            win_index_1 = win_combo[0]
            win_index_2 = win_combo[1]
            win_index_3 = win_combo[2]

            position_1 = @board[win_index_1]
            position_2 = @board[win_index_2]
            position_3 = @board[win_index_3]

            if position_1 == "X" && position_2 == "X" && position_3 == "X"
                return win_combo
            elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
                return win_combo
            end
        end
        return false 


    end

    def full?
        turn_count == 9 ? true : false
    end

    def draw? 
        full? && !won? ? true : false
    end
    
    def over? 
        draw? || won? ? true : false
    end

    def winner

        if !won? 
            return nil 
        end

        won? && current_player == "X" ? "O" : "X"
    end
    
    def play
        until over?
            turn
        end
        puts "Congratulations #{winner}!" if won?
        puts "Cat's Game!" if draw?
    end

end
