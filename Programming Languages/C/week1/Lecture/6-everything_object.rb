3+4;
# above is syntactic sugar for the following:
3.+(4)

3.nonzero? # returns the number itself, unless the number is 0
0.nonzero? # returns nil

nil.nil? # returns true. Only true for nil, everything else
# including empty string and 0 will return false if called .nil? on it

# note that nil is considered false.
if nil then puts "A" else puts "B" end # prints B.

# All objects have .methods and .class methods. 
# .methods : list all methods an object has
# .class : show what class an object belongs to

puts 3.class
print 3.methods