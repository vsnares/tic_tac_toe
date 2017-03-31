class View

  def clear_screen
    puts "\e[H\e[2J"
  end

  def instructions
    clear_screen
    puts "          Instructions"
    puts " "
    puts "      Place three of your  "
    puts "   symbols in a line to win."
    puts "            "
    puts "    |1|2|3|     Select boxes    "
    puts "    |4|5|6|      using 1-9"
    puts "    |7|8|9|"
    puts ""
    puts "    Please enter size if the square:"
  end

  def game_state(board, side_size)
    clear_screen
    puts "        TicTacToe"
    puts " "
    side_size.times do |i|
      puts "        #{board.print_row(i+1)}    "
    end
    puts ""
    puts "     If you want restart the round please enter 'restart'    "
    puts ""
  end
end