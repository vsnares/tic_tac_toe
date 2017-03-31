class GameBoard
  attr_accessor :side_size, :cell_count

  def initialize(n=3)
    @side_size = n
    @cell_count = n*n
    @board = {}

    @cell_count.times do |i|
      @board.merge!(i+1 => "_")
    end
  end

 def print_row(board_row = nil)
    cell_number = 1
    @side_size.times do |c|
      row = ""
      @side_size.times do |i|
        row << "|#{@board[cell_number]}"
        return (row << "|") if (i+1 == @side_size && board_row == (cell_number / @side_size))
        cell_number += 1
      end
    end
  end

  def place_marker(location, marker)
    if @board[location] == "_"
      @board[location] = marker
    else
      return "occupied"; end
  end


  def check_winner(winner = nil)
    # Check rows
    @board.values.each_slice(@side_size) do |row|
      return winner = row.first if row.uniq.size == 1
    end

    # Check columns
    @side_size.times do |time|
      current_column = time.step(@board.size - 1, @side_size).map { |i| @board[i] }
      return winner = current_column.first if current_column.uniq.size == 1
    end

    sliced = @board.values.each_slice(@side_size).to_a

    left_diagonal, right_diagonal = (0..@side_size-1).each_with_object([[], []]) do |i, a|
      a[0] << sliced[i][i]
      a[1] << sliced[i][-i-1]
    end

    # Check top left - bottom right diag
    if left_diagonal.uniq.size == 1
      return winner = left_diagonal.first
    end

    # Check top right - bottom left diag
    if right_diagonal.uniq.size == 1
      return winner = right_diagonal.first
    end
  end

end