require_relative "board"
require 'YAML'
require_relative "score_board"

class Minesweeper
  attr_reader :board

  def initialize
    @board = Board.new
    @seconds = 0
    @score_board = YAML.load_file("score_board.yml")
    run
  end

  def run
    time = Time.now
    until game_won? || game_lost?
      board.render
      save_game = get_save_request
      if save_game == "y"
        @seconds += (Time.now - time).to_i
        File.open("minesweeper-save.yml", "w") { |f| f.puts self.to_yaml }
        exit
      end
      position, action = get_input
      if action == "f"
        board.flag_pos(position)
      else
        board.reveal_pos(position)
      end
    end
    board.render
    if game_won?
      @seconds += (Time.now - time).to_i
      @score_board.add_record(@seconds)
      @score_board.render
      File.open("score_board.yml", "w") { |f| f.puts @score_board.to_yaml }
      puts "Congratulations you won"
    else
      puts "You died"
    end
  end

  def get_save_request
    puts "Do you want to save and exit?(y/n) "
    gets.chomp
  end

  def game_won?
    board.bombs_flags_matched? && board.safe_spots_revealed?
  end

  def game_lost?
    board.all_revealed?
  end

  def get_input
    puts "What position would you like to inspect? "
    position = gets.chomp.split(",").map(&:to_i)
    puts "(I)nspect or (F)lag? "
    action = gets.chomp.downcase
    [position, action]
  end

end

if __FILE__ == $PROGRAM_NAME
  if !File.exist?("score_board.yml")
    File.open("score_board.yml", "w") { |f| f.puts Scoreboard.new.to_yaml }
  end
  puts "Load from file?(y/n) "
  if gets.chomp == "y"
    game = YAML.load_file("minesweeper-save.yml")
    game.run
  else
    game = Minesweeper.new
    game.run
  end
end
