# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = self
    arr.to_a
    i = 0
    while i < size
      yield(arr[i])
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

  def my_all?(pattern = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    if block_given? && pattern.nil?
      my_each { |item| return false unless yield item }
    elsif pattern.is_a? Regexp
      my_each { |item| return false unless item =~ pattern }
    elsif pattern.is_a? Class
      my_each { |item| return false unless item.is_a? pattern }
    elsif pattern.nil? && !block_given?
      my_each { |item| return false unless item }
    elsif pattern
      my_each { |item| return false unless item == pattern }
    end
    true
  end

  def my_any?(pattern = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    if block_given? && pattern.nil?
      my_each { |item| return true if yield item }
    elsif pattern.is_a? Regexp
      my_each { |item| return true if item =~ pattern }
    elsif pattern.is_a? Class
      my_each { |item| return true if item.is_a? pattern }
    elsif pattern
      my_each { |item| return true if item == pattern }
    elsif pattern.nil? && !block_given?
      my_each { |item| return true if item }
    end
    false
  end

  def my_none?(pattern = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    if block_given? && pattern.nil?
      my_each { |item| return false if item }
    elsif pattern.is_a? Regexp
      my_each { |item| return false if item =~ pattern }
    elsif pattern.is_a? Class
      my_each { |item| return false if item.is_a? pattern }
    elsif pattern
      my_each { |item| return false if pattern == item }
    elsif !pattern && !block_given?
      my_each { |item| return false if item }
    end
    true
  end

  def my_count(item = nil, &block) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    count = 0
    my_each { |e| count += 1 if block.call(e) } if block_given?
    return count if block_given?

    my_each { |e| count += 1 if e == item } if item
    return count if item

    my_each { count += 1 } if !item && !block_given?
    count
  end

  def my_map(&block)
    return to_enum(:my_map) unless block_given?

    arr = []
    my_each { |item| arr << block.call(item) } if block_given?
    arr
  end

  def my_inject(initial = nil, sym = nil, &block) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    acc = initial || first
    acc = first if initial.class == Symbol
    acc = initial if !initial.class == Symbol
    acc -= acc if acc != initial && acc.class != String
    my_each { |e| acc = block.call(acc, e) } if block_given?
    my_each { |e| acc = acc.send(sym, e) } if initial && sym
    my_each { |e| acc = acc.send(initial, e) } if initial.class == Symbol
    acc
  end
end

def multiple_els(arr)
  arr.my_inject(1) { |acc, item| acc * item }
end

puts multiple_els([2, 4, 5])
