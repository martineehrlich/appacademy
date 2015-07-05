require "byebug"
class Scoreboard
  attr_accessor :board
  def initialize
    @board = []
  end

  def add_record(time)
    puts "What is your name? "
    name = gets.chomp
    @board << {:name => name, :time => time}
  end

  def sort!
    debugger
    @board.sort! { |i, j| j[:time] <=> i[:time] }
  end

  def render
    @board.sort!.each_with_index do |info, idx|
      puts "#{idx + 1}: #{info[:name]}: #{info[:time]}"
    end
  end

end
