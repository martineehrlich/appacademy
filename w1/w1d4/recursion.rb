require 'byebug'

def range(first, last)
  return [] if last <= first + 1
  val = first + 1
  [val] + range(val, last)
end

def sum_recursive(arr)
  return 0 if arr.empty?
  arr.shift + sum_recursive(arr)
end

def sum_iterative(arr)
  idx = 0
  sum = 0
  while idx < arr.length
    sum += arr[idx]
    idx += 1
  end
  sum
end

def exp_one(base, power)
  return 1 if power == 0
  base * exp_one(base, power - 1)
end

def exp_two(base, power)
  return 1 if power == 0
  return base if power == 1
  if power % 2 == 0
    value = exp_two(base, power / 2)
    return value * value if power % 2 == 0
  else
    value2 = exp_two(base, (power - 1) / 2)
    base * value2 * value2
  end
end

def deep_dup(array)
  return array.dup if array.none? { |el| el.is_a?(Array) }
  duplicate_array = array.dup
  var = duplicate_array.shift
  [deep_dup(var)] + deep_dup(duplicate_array)
end

def fibonacci(n)
  return [] if n == 0
  return [1] if n == 1
  return [1,1] if n == 2

  array = fibonacci(n-1)
  array << (array[-2] + array[-1])
  array
end

def binary_search(array, target)
  if array.length == 1
    return 0 if target == array.first
    return nil
  end

  midpoint_idx = array.length / 2
  if array[midpoint_idx] == target
    midpoint_idx
  elsif array[midpoint_idx] < target
    subarray = array.drop(midpoint_idx)
    next_idx = binary_search(subarray, target)
    return nil if next_idx.nil?
    midpoint_idx + 1 + next_idx
  else
    subarray = array.take(midpoint_idx)
    binary_search(subarray, target)
  end
end

# def make_change(amount, coins = [25, 10, 5, 1])
#   return [] if amount == 0
#
#   min_coin_array = nil
#
#   coins.each do |coin|
#
#     if amount >= coin
#       new_amount = amount - coin
#       coin_array = [coin] + make_change(new_amount, coins)
#     end
#
#     if min_coin_array.nil? || coin_array.length < min_coin_array.length
#       min_coin_array = coin_array
#     end
#   end
#
#   min_coin_array
# end

def merge_sort(array)
  return array if array.length < 2
  mid = array.length / 2
  merge(merge_sort(array.take(mid)), merge_sort(array.drop(mid)))
end

def merge(arr1, arr2)
  if arr1.first && arr2.first
    new_array = (arr1.first > arr2.first) ? [arr2.shift] : [arr1.shift]
    new_array + merge(arr1, arr2)
  else
    arr1.empty? ? arr2 : arr1
  end
end

def subsets(arr)
  return [[]] if arr.empty?
  base = subsets(arr.drop(1))
  base + base.map { |el| el + [arr.first] }
end
