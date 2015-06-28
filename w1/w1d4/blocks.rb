class Array

  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
    self
  end

  def my_map
    new_array = []
    self.my_each { |el| new_array << yield(el) }
    new_array
  end

  def my_select
    new_array = []
    self.my_each do |el|
      new_array << el if yield(el)
    end
    new_array
  end

  def my_inject
    accumulator = nil
    self.my_each do |el|
      if accumulator.nil?
        accumulator = el
      else
        accumulator = yield(accumulator, el)
      end
    end
      accumulator
  end

  def my_sort(&prc)
    return self if self.length < 2
    pivot = self.first
    left, right = [],[]
    self.drop(1).my_each do |el|
      if prc.call(pivot, el) < 0
        right << el
      else
        left << el
      end
    end
    left.my_sort!(&prc) + [pivot] + right.my_sort!(&prc)
  end

  def my_sort!(&prc)
    sorted = false
    until sorted
      sorted = true
      for idx in (0...self.length - 1)
        if prc.call(self[idx], self[idx+1]) > 0
          self[idx], self[idx+1] = self[idx+1], self[idx]
          sorted = false
        end
      end
    end
      return self
  end
end

def eval_block(*args, &prc)
  if prc.nil?
    puts "NO BLOCK GIVEN!"
  else
    prc.call(* args)
  end
end
