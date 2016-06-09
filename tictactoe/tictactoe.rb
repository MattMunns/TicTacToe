require_relative 'player'
require_relative 'board'

class Game
	@player1
	@player2
	@board
	@turn_count

	#Beginning function for setting up each player
	def start_tic_tac_toe
		opening_dialogue
		new_game
	end

	#Begins the actual game 
	def new_game
		@turn_count = 0
		initalize_board
		game_start
	end

	# Dialogue for starting the game and choosing player conditions
	def opening_dialogue
		puts 'Welcome to Ruby Tic Tac Toe!'
		puts 'For Starters, what is the name of our player!'
		print 'Player 1 name: '
		@player1 = Player.new(gets.chomp,'X')
		puts 'Greetings, '+@player1.name+' !'
		puts 'Please enter a name for player 2'
		@player2 = Player.new(gets.chomp, 'O')
		
	end

	#quick function to create player objects to speed up testing
	def quick_player_test
		@player1 = Player.new('Matt', 'X')
		@player2 = Player.new('Andrew','O')
	end

	#Create an instance of the game board class
	def initalize_board
		@board = Board.new()
	end

	#randomize who goes first between the two players
	def first_move
		rand_num = rand(1..3)
		return rand_num
	end

	#decide who plyas first and pass the appropriate objects to begin taking turns
	def game_start
		whose_turn = first_move
		if(whose_turn === 1)
			moves_first = @player1
			other_player = @player2
		else
			moves_first = @player2
			other_player = @player1
		end

		puts 'Congratulations '+ moves_first.name+', you move first!'

		take_turn(moves_first,other_player)
	end

	#Accept the player whose turn it is to move and the other player
	# => We do this because than we can just recursively call this function with reverse parameters 
	# => until the game ends.
	def take_turn(current_moving_player,other_player)
		@board.display_board		
		win_test = false
		#logic to see if valid move
		valid = false
		while !valid do
			puts current_moving_player.name + ', make your move by entering the number of the square you would like to place your piece.'
			player_move = gets.chomp
			if ( @board.check_valid(player_move.to_i, current_moving_player.piece) )
				valid = true
				win_test = @board.did_player_win
			else
				puts "Invalid move, try again."
			end
		end
		
		#test for win, if game is over handle ending
		# => else continue taking turns
		if( !win_test )
			@turn_count += 1

			if(@turn_count < 9)
				take_turn(other_player,current_moving_player)
			else
				puts 'The game is a DRAW'
				play_again
			end
		else
			@board.display_board
			puts current_moving_player.name + ' has won the game!!'
			play_again
		end		
	end

	#Allows the user to play the game again or simply quit
	def play_again
		again = false
		while !again
			puts 'Press 1 to play again, 2 to quit'
			response = gets.chomp.to_i
			if(response == 1)
				again = true
				new_game
			elsif response == 2
				exit
			end
		end
	end
end

game = Game.new()
game.start_tic_tac_toe()