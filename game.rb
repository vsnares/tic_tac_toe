require "./gameboard.rb"
require "./view.rb"
require "./player.rb"

class Game

  def initialize
    @view = View.new
    @continue_game = true
    @continue_round = true
    puts "\e[H\e[2J"
    main_menu
  end

  def main_menu
    @player_one = Player.new(:p1, "Player1", "X")
    @player_two = Player.new(:p2, "Player2", "O")
    @view.instructions
    side_size = gets.chomp.to_i
    @board = GameBoard.new(side_size)
    main_loop
  end


  def main_loop
    @active_player = @player_one
    @continue_round = true

    while @continue_round
      valid_input = false

      until valid_input
        @view.game_state(@board, @board.side_size)
        print " #{@active_player.name}'s turn. Select (1-#{@board.cell_count}): "
        location = gets.chomp

        if location.to_i.between?(1,@board.cell_count)
          valid_input = true

          if @board.place_marker(location.to_i, @active_player.marker) == "occupied"
            puts "That spot is already taken... try again."
            valid_input = false
            sleep 1
          end

        elsif location.downcase == "restart"
          main_loop # Restart the game
        else
          puts " Invalid entry, please try again."
          sleep 1
        end
      end

      @view.game_state(@board, @board.side_size)

      if @board.check_winner == @player_one.marker || @board.check_winner == @player_two.marker
        @continue_round = false
        puts "         #{@active_player.name} Wins!"
        sleep 1;
      end

      @active_player == @player_one ? @active_player = @player_two : @active_player = @player_one
    end

    sleep 2
    main_menu
  end
end

thisgame = Game.new