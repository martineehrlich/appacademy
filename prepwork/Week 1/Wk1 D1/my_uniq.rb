class Array

def uniq(array)
  uniq_array = []

array.each do |el|
  if !uniq_array.include?(el)
     uniq_array.push(el)
  end
 end

 uniq_array
 end
