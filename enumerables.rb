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
    self
    end
  end

  def my_select 
    return to_enum(:my_select) unless block_given?

    result = []
    my_each { |item| return.push(item) if yield (item) }
    result 
  end

  def my_all?(pattern = nil)
    result = true
    if block_given?
      my_each { |ele| result &= (yield ele) }
    elsif pattern
      my_each { |ele| result &= pattern === ele }
    else
      my_each { |ele| result &= ele }
    end
    result
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |ele| return true if yield ele }
    elsif pattern
      my_each { |ele| return true if pattern === ele }
    else
      my_each { |ele| return true if ele }
    end
    false
  end

  def my_none?
    return to_enum(:my_none) unless block_given?
    
    my_each {|item| return false if yield(item)}
    false
  end

  def my_count
    count = 0
    if block_given?
      my_each {|item| count +=1 if yield(item)}
    else
    count
  end

  def my_map
    result = []
    my_each { |item| result << yield(item) }
    result
  end

   # 11 =>  puts arr.my_map(proc)

  def my_inject(acc=0)
    result = []
    my_each { |item| acc = yield(acc, item) }
    acc
  end
end
  
arr [1, 2, 3, 4]

def multiple_els arr
  arr.my_inject(1) { |acc, item| acc * item }
end
puts multiple_els([2, 4, 5])

# 12
puts arr.my_map { |item| item >= 2 }
puts
proc = proc{ |item| item >= 2 }
puts arr.my_map(proc)
