class MyHashSet
  attr_reader :store

  def initialize
    @store = {}
  end

  def insert(element)
    @store[element] = true
  end

  def include?(element)
    store.include?(element)
  end

  def delete(element)
    if self.include?(element)
    store.delete(element)
      true
    else false
    end
  end

  def to_a
    store.keys
  end

  def union(set2)
    new_set = MyHashSet.new
    self.to_a.each { |el| new_set.insert(el) }
    set2.to_a.each { |el| new_set.insert(el) }
    new_set
  end

  def intersect(set2)
    new_set = MyHashSet.new
    self.to_a.each do |el|
      if set2.include?(el)
        new_set.insert(el)
      end
    end
    new_set
  end

  def minus(set2)
    new_set = MyHashSet.new
    self.to_a.each do |el|
     if !set2.include?(el)
      new_set.insert(el)
    end
    end
    new_set
  end

end

newe_set = MyHashSet.new
newer_set = MyHashSet.new

newe_set.insert(:key)
newe_set.insert(:banana)
newer_set.insert(:key2)
newer_set.insert(:key)

puts newe_set.union(newer_set)
puts newe_set.intersect(newer_set)
puts newe_set.minus(newer_set)
