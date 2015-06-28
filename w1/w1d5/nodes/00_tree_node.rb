require "byebug"

MAX_STACK_SIZE = 200
tracer = proc do |event|
  if event == 'call' && caller_locations.length > MAX_STACK_SIZE
    fail "Probable Stack Overflow"
  end
end
set_trace_func(tracer)

class PolyTreeNode
  attr_reader :children, :value, :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    unless new_parent == parent
      @parent.children.delete(self) unless parent.nil?
      @parent = new_parent
      new_parent.children << self unless new_parent.nil?
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def trace_path_back
    path_array = []
    current_node = self
    until current_node.nil?
      path_array << current_node.value
      current_node = current_node.parent
    end

    path_array.reverse
  end

  def inspect
    "PolyTreeNode:#{@value}"
  end

  def remove_child(child_node)
    raise "Node not a child" unless self.children.include?(child_node)

    @children.delete(children.index(child_node))
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if value == target_value

    children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end

    nil
  end

  def bfs(target_value)
     queue = MyQueue.new
     queue.enqueue(self)

     until queue.empty?
       current = queue.dequeue
       return current if target_value == current.value
       queue.enqueue(*current.children)
     end

     nil
  end
end

class MyQueue
  attr_reader :queue

  def initialize
    @queue = []
  end

  def enqueue(*els)
    @queue.concat(els)
  end

  def dequeue
    @queue.shift
  end

  def empty?
    self.queue.empty?
  end
end

if __FILE__ == $PROGRAM_NAME
  n1 = PolyTreeNode.new("root1")
  n2 = PolyTreeNode.new("root2")
  n3 = PolyTreeNode.new("root3")
  n2.parent = n1
  n3.parent = n1
  n2.parent = nil
  p n1.children
end
