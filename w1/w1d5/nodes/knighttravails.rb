require_relative '00_tree_node.rb'
require 'byebug'

class KnightPathFinder

  DELTAS = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]]

  attr_reader :visited_positions, :starting_node

  def initialize(starting_pos = [0, 0])
    @starting_node = PolyTreeNode.new(starting_pos)
    @visited_positions = [starting_pos]
  end

  def self.valid_moves(pos)
    x, y = pos
    valid_moves = []
    DELTAS.each do |dx, dy|
      row, col = x + dx, y + dy
      valid_moves << [row, col] if row.between?(0, 7) && col.between?(0, 7)
    end

    valid_moves
  end

  def new_move_positions(pos)
    new_moves = self.class.valid_moves(pos) - visited_positions
    self.visited_positions.concat(new_moves)

    new_moves
  end

  def build_move_tree
    queue = MyQueue.new
    queue.enqueue(@starting_node)

    until queue.empty?
      current_node = queue.dequeue
      new_move_positions(current_node.value).each do |pos|
        node = PolyTreeNode.new(pos)
        current_node.add_child(node)
        queue.enqueue(node)
      end
    end
  end

  def find_path(end_pos)
    @starting_node.bfs(end_pos).trace_path_back
  end
end

if __FILE__ == $PROGRAM_NAME
  knight = KnightPathFinder.new([0,0])
  knight.build_move_tree
  p knight.find_path([6,2])
end
