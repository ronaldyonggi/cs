# Example of creating arrays
a = [3, 2, 7, 9]
a[0] # returns 3
a[3] # returns 9
# However in ruby, if we go out of bound, it will return nil
# instead of an error.
a[1000] # returns nil.

a.size # Returns the size, in this case 4

a[-1] # get the last element of the array. [-2] gets the 2nd last

# If we assign an array an element at index greater than its
# max index, ruby will extend the array, with nils 
# among the non-assigned elements.
a[6] = 14
# a is now [3, 6, 7, 9, nil, nil 14]

# ruby array can contain multiple data types
a[1] = "hi"
b = a + [true, false]

# The '|' takes 2 arrays and returns an array without duplicates
c = [3,2,3] | [1,2,3] # returns [3,2,1]

Array.new(5) # creates an array of size 5 with all elements nil
Array.new(5) {1} # creates an array of size 5 with all elements 1
# Below, creates an array with all elements 0, -1, -2, -3, ...
Array.new(5) {|i| - i}

a = [3, 2, 7, 9]
a.push 5 # Adds 5 to the end of the array
a.pop # returns and on the same time remove the last element from the array, which is 5
a.shift # returns and on the same time remove the FIRST element from the array, 3
# Also all elements are shifted to the left, so a[0] is now 2
a.unshift 20 # adds an element to the beginning of the array.


## ALIASING
d = a # d is now the same object as a
e = a + [] # e is DIFFERENT from a. e just have the same contents as a.

lol = [0,1,2,3,4,5,6,7]
lol[2,4] # starting from lol[2], gives back 4 elements. Thus returns [2,3,4,5]
lol[2,4] = ["hi","ha"] # replace the [2,3,4,5] with ["hi", "ha"]
#thus lol is now [0, 1, "hi", "ha", 6, 7]

[1,3,4,12].each {|i| puts (i*i)}
# prints the result of i*i for each element in the array.