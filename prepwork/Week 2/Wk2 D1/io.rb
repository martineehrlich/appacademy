
def guess_number
  puts "guess a number between 1 and 10"
number = 1 + rand(1..10)
guess = gets.to_i
number_of_guesses = 0

while number != guess

  if guess < number
    puts "too low, pick again"
  else
    puts "too high, pick again"
  end
  number_of_guesses += 1
  guess = gets.to_i

end

puts number_of_guesses
puts "correct!"


end

def file_shuffler

puts "enter a file"
file_name = gets
contents = File.readlines(file_name)
shuffled_file = contents.shuffle

File.open("#{file_name}-shuffled", "w") do |f|
  f.puts shuffled_file
end

end
