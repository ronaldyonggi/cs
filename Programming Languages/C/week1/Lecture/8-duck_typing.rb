# Example: in cartesian coordinates, if you mirror a point, 
# simply negate it.
def mirror pt
    pt.x = pt.x * (-1)
end

# At first, might think that this method takes a Point object.
# Turns out this method can take anything with 
# getter and setter for @x, then multiplty the x by -1.

# Closer look, it can take anything with methods 'x=' and x and 
# calls x= with the result of multiplying x field by -1.

# Duck typing: This method takes anything with method x= and x
# where result of x has a '*' method that can take -1. Returns 
# the result of calling x the * message with -1 and send the result
# to x=.