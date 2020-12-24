3.times {puts "hi"} # prints "hi" 3 times

[4,6,8].each {puts "hi"} # prints "hi" for each element found in the array


i = 7
[4,6,8].each {|x| if i > x then puts (x+1) end}

# blocks are ruby's efficient version of loops

a = Array.new(5) {|i| 4 * (i + 1)}
# a is now [4,8,12,16,20]

a.map {|x| x * 2} # synonym: collect
a.any? {|x| x > 7} 
a.all? {|x| x > 7} 
a.select {|x| x > 7} #non-synonym: filter

# inject is like reduce (or sum, or accumulator).
# The provided argument 0 is the starting element. If it's not provided,
# ruby by default starts with the first element.
a.inject(0) {|acc,elt| acc + elt}

# Below is a nested loop function that when called with an argument
# prints a triangular shape of numbers
def t i
    (0..i).each do |j|
        print " " * j
        (j..i).each {|k| print k; print " "}
        print "\n"
    end
end

t 9