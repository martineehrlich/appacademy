def my_transpose(array)
array_new = []
  idx = 0
  while idx < array.length
  array_new.push([array.map do |row| row[idx]
  end])
  idx += 1
end
array_new
end

puts my_transpose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ])
