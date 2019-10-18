
module Enumerable

def my_each
 i = 0
 while i < size
  yield (self[i])
  i += 1 
 end
 self
end

def my_each_whit_index
 i = 0
 while i < size 
  yield (self[i],i)
  i += 1
  self
 end
end

def my_select 
  result = []
  my_each {|item| return true if yield (item) }
  result 
end

def my_all?
  my_each {|item| return true if yield(item)}
  false
end

















