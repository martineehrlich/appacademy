class Game

    def initialize
        @t1 = [3, 2, 1]
        @t2 = []
        @t3 = []
    end

    def play
     puts "Welcome to Towers of Hanoi!"

   while @t2 != [3, 2, 1] && @t3 != [3, 2, 1]

    puts "Select a tower to choose from."
    print_towers
    tower_from = gets.chomp.to_i
    puts "select the tower to move your disc to."
    tower_to = gets.chomp.to_i

    move_disc(tower_from, tower_to)

    check_game

    end

end

    def print_towers
        p @t1
        p @t2
        p @t3
    end

def translate(input)

    if input == 1
        @t1
    elsif input == 2 
        @t2
    elsif input == 3
        @t3
    end
end



def move_disc(tower_from, tower_to)
    tower_from = translate(tower_from)
    tower_to = translate(tower_to)
        if tower_from.empty?
            puts "tower is empty, pick again"
        elsif tower_to.empty? || tower_to.last > tower_from.last
            tower_to.push(tower_from.last)
            tower_from.pop
        else
            puts "cant put larger disc on smaller disc, pick again"
        end
end

        def check_game
            if @t2 == [3, 2, 1] || @t3 == [3, 2, 1]
                puts "yay you won!"
            end

         end


end



game = Game.new
game.play
