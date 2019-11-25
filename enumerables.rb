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
      my_each { |item| result &= pattern == item || pattern == item.class }
    else
      my_each { |item| result &= item }
    end
    result
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |item| return true if yield item }
    elsif pattern.is_a? Regexp
      my_each { |item| return true if item =~ pattern }
    elsif pattern.is_a? Class
      my_each { |item| return true if pattern == item.class }
    elsif pattern
      my_each { |item| return true if pattern == item || pattern == item.class }
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
    return to_enum unless block_given?
    result = []
    my_each { |item| result << yield(item) }
    result
  end

  def my_inject(acc = 0)
    my_each { |item| acc = yield(acc, item) }
    acc
  end
end

def multiple_els(arr)
  arr.my_inject(1) { |acc, item| acc * item }
end

abc = [1,2,3,4]
array = [4, 3, 2, 6, 2, 8, 8, 3, 0, 4, 8, 3, 4, 8, 1, 5, 2, 5, 6, 3, 1, 8, 2, 1, 1, 5, 3, 6, 0, 4, 8, 6, 7, 6, 2, 4, 3, 8, 1, 3, 5, 1, 0, 2, 6, 1, 1, 2, 2, 1, 7, 5, 4, 5, 2, 3, 5, 1, 3, 4, 1, 4, 3, 2, 0, 5, 4, 7, 1, 4, 1, 1, 8, 6, 8, 7, 3, 7, 6, 3, 6, 8, 4, 1, 1, 3, 5, 8, 7, 1, 2, 2, 4, 5, 7, 2, 5, 8, 0, 0]

puts array.all?(Numeric)
puts array.my_all?(Integer)

