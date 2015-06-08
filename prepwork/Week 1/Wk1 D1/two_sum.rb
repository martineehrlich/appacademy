def two_sum(array)
  array_new = []
  idx = 0
  while idx < array.length
    idx2 = idx + 1
    while idx2 < array.length
      if array[idx] + array[idx2] == 0
        array_new.push([idx, idx2])
      end
      idx2 +=1
    end
    idx += 1
  end

  return array_new

end

puts two_sum([1, 2, -2, 1, 0, -1])
