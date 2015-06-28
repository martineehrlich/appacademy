require_relative 'tic_tac_toe'

class TicTacToeNode
attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  def alternate_mover_mark
    next_mover_mark == :x ? :o : :x
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    array = []
    @board.rows.each do |row|
      @board.row.each do |el|
        if el.empty?
          new_board = @board.dup
          new_board[row][el] = @next_mover_mark
          prev_move = [row, el]
          new_node = TicTacToeNode.new(new_board, alternate_mover_mark, prev_move)
          array << new_node
        end
      end
    end
    array
  end

end
