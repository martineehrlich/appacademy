def factors(num)
  (1..num).select { |n| num % n == 0}
end

def bubblesort(array)
    sorted = false
  while sorted == false
    sorted = true
    array.each_index do |i|

      next if (i + 1) == array.count

      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
  		  sorted = false
  	  end

    end

  end

  array

end

require 'set'

def substrings(string)
  substrings = []
  array = string.split("")
  array.each_index do |word_start|
    array.each_index do |word_end|
      next if word_end < word_start
      sub = array[word_start..word_end].join("")
      substrings << sub if !substrings.include?(sub)
    end
  end

  substrings

end


def subwords(word)
  dictionary = Set.new(File.read("dictionary.txt").split("\n"))
  substrings(word).select { |sub| dictionary.include?(sub)}
end

p subwords("fantastical")
p substrings("cat")
