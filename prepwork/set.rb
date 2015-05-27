class MyHashSet
  attr_accessor :store

  def initialize
    @store = {}
  end

  def insert(element)
    @store[element] = true
  end

  def include?(element)
    @store.include?(element)
  end

  def delete(element)
    if @store.include?(element)
    @store.delete(element)
      true
    else false
    end
  end

  def to_a
    @store.to_a
  end

  def union(set2)
    @store.merge(set2.store)
  end

  def intersect(set2)
    @store.select do |k, v|
      set2.store.include?(k)
    end
  end

  def minus(set2)
    @store.select do |k, v|
     !set2.store.include?(k)
    end
  end

end

new_set = MyHashSet.new
newer_set = MyHashSet.new

new_set.insert(:key)
new_set.insert(:banana)
newer_set.insert(:key2)
newer_set.insert(:key)

puts new_set.union(newer_set)
puts new_set.intersect(newer_set)
puts new_set.minus(newer_set)
