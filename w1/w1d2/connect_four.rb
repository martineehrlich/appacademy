require 'byebug'
require 'colorize'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def columns
    grid.transpose
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def render
    grid.each do |row|
      row.each do |el|
        print el
      end
      puts
    end
  end

  def drop_disc(column, disc)
    if full?(column)
      return false
    else
      self[[avail_row(column), column]] = disc
      return true
    end
  end

  def avail_row(column_idx)
    row = 0
    columns[column_idx].reverse.map.with_index do |el, i|
      row = (5 - i) if el.nil?
      break if el.nil?
    end
    return row
  end

  def over?
    winner?
  end

  def winner?
    # contains the logic to check rows, columns, and diagonals
    full_check?
    # return "o".blue.red
    # return "o".blue
  end

  def check(pos)

    i, j = pos[0], pos[1]
    m, n = i + 4, j + 4

    rows = []
    columns = []
    diag_one = [self[[i,j]], self[[i + 1, j + 1]], self[[i + 2, j + 2]], self[[i + 3, j + 3]]]
    diag_two = [self[[i + 3,j]], self[[i + 2, j + 1]], self[[i + 1, j + 2]], self[[i, j + 3]]]

    while i < m
      j = pos[1]
      while j < n
        # debugger
        rows << self[[i,j]]
        columns << self[[j,i]]
        j += 1
      end
      i += 1
    end

    rows = [rows[0..3], rows[4..7], rows[8..11], rows[12..15]]
    columns = [columns[0..3], columns[4..7], columns[8..11], columns[12..15]]

    total = rows + columns + diag_one + diag_two

    # debugger
    columns.include?(winning_array_red) || columns.include?(winning_array_blue)

  end

  def full_check?
    i = 0
    j = 0
    while i < 2
      j = 0
      while j < 3
        if check([i,j])
          return true
        end
        j += 1
      end
      i += 1
    end
    false
  end

  def full?(column_idx)
    columns[column_idx].all? { |el| !el.nil? }
  end

  def winning_array_red
    return Array.new(4) { "o".blue.red }
  end

  def winning_array_blue
    return Array.new(4) { "o".blue }
  end

end

class Game

  attr_accessor :players, :board, :turn

  def initialize(player_one, player_two)
    @players = {"o".blue.red => player_one, "o".blue => player_two}
    @turn = "o".blue.red
    @board = Board.new
  end

  def run
    until board.over?
      board.render
      until board.drop_disc(players[turn].make_move, turn)
        board.drop_disc(players[turn].make_move, turn)
      end
      turn
    end
    turn
    p "#{players[turn].name} has won the game!"
  end

  def drop_disc_board
    board.drop_disc(column, turn) == false
  end

  def turn
    @turn == "o".blue.red ? @turn = "o".blue : @turn = "o".blue.red
  end
end

class Player

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def make_move
    p "Please pick a column you would like to place your piece (0-7)"
    column = gets.chomp.to_i
    if (0..7).to_a.include?(column)
      column
    else
      p "Please make a valid move"
      make_move
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  player_one = Player.new("one")
  player_two = Player.new("two")
  game = Game.new(player_one, player_two)
  game.run
end
