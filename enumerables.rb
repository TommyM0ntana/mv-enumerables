# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    i = 0
    result = []
    while i < length
      answer = yield(self[i])
      result << self[i] unless answer == false
      i += 1
    end
    result
  end

  def my_all?(pattern = nil)
    result = true
    if block_given?
      my_each { |item| result &= (yield item) }
    elsif pattern
      my_each { |item| result &= pattern == item }
    else
      my_each { |item| result &= item }
    end
    result
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |item| return true if yield item }
    elsif pattern
      my_each { |item| return true if pattern == item }
    else
      my_each { |item| return true if item }
    end
    false
  end

  def my_none?
    return to_enum(:my_none) unless block_given?

    my_each { |item| return false if yield(item) }
    false
  end

  def my_count
    count = 0
    if block_given?
      my_each { |item| count += 1 if yield(item) }
    else
      count
    end
  end

  def my_map
    result = []
    my_each { |item| result << yield(item) }
    result
  end

  def my_inject(acc = 0)
    my_each { |item| acc = yield(acc, item) }
    acc
  end
end

#arr[1, 2, 3, 4]

def multiple_els(arr)
  arr.my_inject(1) { |acc, item| acc * item }
end


r = [1,2,3,4]
puts r.my_map{|n| n*2}

puts r.map{|n| n*2}