def rps(user_input)
  win = {:rock => "scissors", :paper => "rock" , :scissors => "paper" }
  choices = ["rock", "paper", "scissors"]

  computer_choice = choices.sample

  if computer_choice == user_input
    return  "#{computer_choice},draw"
  end

  if win[user_input.to_sym] == computer_choice
    "#{user_input},win"
  else
    "#{user_input},lose"
  end


end



def mixer(array)

  alcohols = array.map {|i| i[0]}
  mixers = array.map {|i| i[1]}

  alcohols.shuffle!
  mixers.shuffle!

  mixed_array = []
  alcohols.length.times do |i|
  mixed_array << [alcohols[i], mixers[i]]
  end
  mixed_array
end
