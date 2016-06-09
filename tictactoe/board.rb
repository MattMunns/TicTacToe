class Board
	attr_accessor :board_state

	def initialize
		empty_board
	end

	# Empties the board for a new game
	def empty_board
		@board_state = ('1'..'9').to_a
	end

	# Displays the current game board's state
	def display_board
		@board_state.each_with_index do |val, index|
			if [0,3,6].include?(index) 
				print @board_state[index] + ' | ' 
			end
			if [1,4,7].include?(index)
				print @board_state[index] + ' | '
			end
			if [2,5,8].include?(index)
				print @board_state[index] + "\n"				
			end
			if [2,5].include?(index)
				puts '----------'
			end
		end		
	end

	#checks if move is valid on the current board
	#position will be an integer 
	def check_valid(position,piece)
		#first we check that their input is a valid spot on the game board
		if(! @board_state[position-1].nil?)
			#now we're checking that the spot isn't already occupied
			if(@board_state[position-1] == position.to_s)
				@board_state[position-1] = piece
				return true
			end
		end
		return false
	end

	def did_player_win
		if(check_rows || check_columns || check_diagonals)
			return true
		else
			return false
		end
	end

	#check if there are any rows of the same piece
	def check_rows
		win_test = false
		(0..6).step(3) do |i|
			if @board_state[i] === @board_state[i+1] && @board_state[i+1] === @board_state[i+2]
				win_test = true
				break
			end
		end
		return win_test
	end

	#check if there are any columns of the same piece
	def check_columns
		win_test = false
		(0..2).each do |i|
			if @board_state[i] === @board_state[i+3] && @board_state[i+3] === @board_state[i+6]
				win_test = true
				break
			end
		end
		return win_test
	end

	#Unfortunately no easy way to hit both diagonals with a loop like we did with rows and columns
	def check_diagonals
		win_test = false
		if @board_state[0] === @board_state[4] && @board_state[4] === @board_state[8]
			win_test = true
		elsif @board_state[2] === @board_state[4] && @board_state[4] === @board_state[6]		 	 
			win_test = true
		end
		return win_test
	end


end
