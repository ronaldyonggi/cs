module Doubler
    def double
        # uses self's message, not defined in Doubler
        self + self 
    end
end

class Pt
    attr_accessor :x, :y
    include Doubler
    def + other
        ans = Pt.new
        ans.x = self.x + other.x
        ans.y = self.y + other.y
        ans
    end
end

class String
    include Doubler
end

# By including module doubler in a class, the class can use the 'double' method!
puts("hello".double) # prints "hellohello"

# These are probably the 2 most common uses in Ruby library

# Comparable and Enumerable
# You define <=> and you get ==, >, <, >=, <= from the mixin.
# (Overrides Object's ==, adds the others)

class Name
    attr_accessor :first, :middle, :last
    # By including Comparable, we get the ==, >, <, >= and <=
    include Comparable

    def initialize(first, last, middle = "")
        @first = first
        @last = last
        @middle = middle
    end

    def <=> other
        l = @last <=> other.last # <=> defined in strings
        return l if l != 0
        f = @first <=> other.first
        return f if f != 0
        @middle <=> other.middle
    end
end

# By default, a <=> b return:
# -1 if a < b
# 0 if a = b
# 1 if a > b
# in Name class, we override <=> so the operator works for Name objects

n1 = Name.new("a", "b", "c")
n2 = Name.new("x", "y", "z")
puts (n1 <=> n2) # prints -1 because when comparing last name,
# n2's "y" is greater than n1's "b"
puts (n2 <=> n1) # prints 1, the opposite of above
puts (n1 <=> n1) # prints 0

puts (n1 < n2) # true

class MyRange
    # Enumerable mixins gives useful methods for ranges
    # such as each, count, any?, map, etc.
    include Enumerable

    def initialize (low, high)
        @low = low
        @high = high
    end

    def each
        i = @low
        while i <= @high
            yield i
            i = i + 1
        end
    end
end

r1 = MyRange.new(3, 7)
r1.each {|i| print i}# prints 3,4,5,6,7

r1.count{|i| i.odd?}

# Mixins work fine for ColorPoint example.
module Color
    def color
        @color
    end

    def color = c
        @color = c
    end

    def darken
        self.color = "dark " + self.color
    end
end

class Pt3D < Pt
    attr_accessor :z

    #...and rest of the implementation
end

class ColorPt < Pt
    include Color
end

class ColorPt3D < Pt3D
    include Color
end