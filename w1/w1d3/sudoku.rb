require 'byebug'

class Tile

  attr_accessor :show, :value, :given

  def initialize(value, given)
    @value = value
    @given = given
  end

  def to_s
    # debugger
    value
  end

end

class Board

  attr_accessor :grid, :grid_values

  def initialize(grid)
    @grid = grid
  end

  def grid_values
    grid.map { |row| row.map { |tile| tile.to_s } }
  end

  def self.from_file(file)
    grid = []

    File.readlines(file).each do |line|
      grid << line.chomp.split("").map { |el| Tile.new(el.to_i, el.to_i != 0) }
    end

    Board.new(grid)
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
        print el.to_s
      end
      puts
    end
  end

  def update_tile(pos, value)
    @grid[*pos] = value
  end

  def full?
    grid_values
    !grid_values.flatten.include?(0)
  end

  def solved?
    p check? && check_squares?
  end

  def check?
    columns_values = grid_values.transpose
    rows_columns = grid_values + columns_values
    rows_columns.each do |row|
      return false if row.uniq != row
    end
    return true
  end

  def place_value(pos, new_value)
    if available?(pos)
      self[pos].value = new_value
    else
      print "You cannot make a change to a given tile\n\n"
    end
  end

  private

  def check_square(pos)
    row = pos[0]
    column = pos[1]

    x = row / 3 * 3
    y = column / 3 * 3
    square = []
    i = x
    j = y
    while i < x + 3
      j = column / 3 * 3
      while j < y + 3
        square << grid_values[x, y]
        j += 1
      end
      i += 1
    end
    square.uniq == square
  end

  def check_squares?
    i = 0
    j = 0
    pos = [i,j]
    while i < 3
      while j < 3
        check_square(pos)
        j += 1
      end
      i += 1
    end
    true
  end

  def available?(pos)
    self[pos].given == false
  end

end

class Sudoku

  attr_accessor :board, :player

  def initialize(player, board)
    @board = board
    @player = player
  end

  def play
    until board.full?
      board.render
      board.place_value(*prompt)
    end
    if board.solved?
      puts "You win!"
    else
      puts "You lose!"
    end
  end

  def prompt
    player.make_guess
  end

end

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def make_guess
    p "What position do you want to play?"
    pos = gets.chomp.split(",").map { |el| el.to_i }
    p "What value would you like to place there?"
    value = gets.chomp.to_i
    if valid_move?(pos, value)
      [pos, value]
    else
      print "Please make a valid move"
      make_guess
    end
  end

  def valid_move?(pos, value)
    (0..8).to_a.include?(pos[0]) && (0..8).to_a.include?(pos[1]) && (1..9).to_a.include?(value)
  end

end

if __FILE__ == $PROGRAM_NAME
  file = "sudoku1.txt"
  board = Board.from_file(file)
  player = Player.new("Joe")
  game = Sudoku.new(player, board)
  game.play
end
