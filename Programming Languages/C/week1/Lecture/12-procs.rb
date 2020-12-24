a = [3,5,7,9]

b = a.map{|x| x + 1} # b is now [4,6,8,10]
i = b.count{|x| x >= 6} # is now 3
# 'count' counts how many elements in an array that fulfill the condition in the block

# Unfortunately, a block can't be nested.
# c = a.map {|x| {|y| x >= y}}  this will throw an error

# However, can do with 'lambda' keyword.
c = a.map {|x| (lambda {|y| x >= y})}
# c is now an array of procs, which can be called with an argument.
# For example, 
c[2].call 17 # This will call c[2] >= 17, or 7 >= 17, which will return false.

# Below calculates how many elements in c that are >= 5. Remember a
# is originally [3,5,7,9] which each holds a proc {|y| x >= y}
c.count {|x| x.call(5)} # should return 3