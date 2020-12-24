#hashes are basically python dictionary.

# Initiate empty hash
h1 = {}
h1["a"] = 3
h1[false] = "hi"
puts h1 # prints all the hashes h1 has currently.
h1[42] # if we ask for an key that doesn't exist, it returns nil
h1.keys # returns all the keys
h1.values # returns all the values.


# An example of directly creating a non-empty hash.
h2 = {"a" => 1, "b" => 2, "c" => 3}
h2.size # prints 3
h2.each {|k,v| print k; print ": "; puts v}
# prints a: 1, b: 2, c: 3, each separated by newline


# A range is an object of continuos elements from starting to ending.
# Think Python range.
1..100 # a range of 1 to 100

(1..100).inject {|acc,elt| acc + elt} # returns the sum from 1 to 100