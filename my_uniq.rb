class Array

def uniq(array)

  new_array = []
  idx = 0
  while idx < array.length
    if new_array.include?(array[idx])
      idx += 1
    else new_array.push(array[idx])
      idx += 1
    end
  end

  return new_array

end

end

arrayb = Array.new([1, 2, 3, 2, 2, 1])
