class Array

  def sum
    self.inject(0) {|sum, num| sum + num}
  end

  def square
    self.map {|num| num ** 2}
  end


  def square!
    self.map! {|num| num ** 2}
  end


end
