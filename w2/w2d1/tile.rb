require "byebug"
class Tile
  attr_reader  :board, :revealed, :value
  attr_accessor :flagged, :bomb

  def initialize(bomb = false, board)
    @revealed = false
    @bomb     = bomb
    @flagged  = false
    @board    = board
    @value    = nil
  end

  def reveal
    @revealed = true
    @value = bomb ? nil : neighbor_bomb_count
  end

  DELTAS = [
    [0, 1],
    [0, -1],
    [1, 1],
    [1, -1],
    [1, 0],
    [-1, -1],
    [-1, 1],
    [-1, 0],
  ]

  def neighbors
    tiles = []
    DELTAS.each do |pos|
      #debugger
      row1, col1 = board.tile_coordinates(self)
      row2, col2 = pos
      pos = [row1 + row2, col1 + col2]
      if valid_pos?(pos)
        tiles << board[pos]
      end
    end
    tiles
  end

  def set_bomb
    self.bomb = true
  end

  def valid_pos?(pos)
    row, col = pos
    row.between?(0, 8) && col.between?(0, 8)
  end

  def neighbor_bomb_count
    count = 0
    # n = neighbors
    neighbors.each {|neighbor| count += 1 if neighbor.bombed? }
    # neighbors.inject(0) { |count, neighbor| neighbor.bombed? ? count + 1 : count }
    count
  end

  def to_s
    if revealed
      if value.is_a?(Integer) && value > 0
        return " #{neighbor_bomb_count} "
      elsif value.is_a?(Integer)
        return "   "
      else
        return " \u2620 " #this is a bomb
      end
    elsif flagged
      " \u2713 " #checkmark for a flag
    else
      "[ ]"
    end
  end

  def bombed?
    return bomb
  end

  def flagged?
    return flagged
  end

  def flag
    @flagged = !flagged
  end

  def inspect
    "#{board.tile_coordinates(self)}"
  end

end
