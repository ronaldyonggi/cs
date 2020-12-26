class Exp
    # could put default implementations or helper methods here
end

class Value < Exp
    # overkill, but useful if you have multiple kinds
    # of values in language that can share methods that don't 
    # make sense for non-value expressions.
end

# New value classes MyString and MyRational
class MyString < Value
    attr_reader :s

    def initialize s
        @s = s
    end

    def eval 
        self
    end

    def toString
        s
    end

    def hasZero  # A string has no zero!
        false
    end

    def noNegConstants
        self
    end

    # double dispatch for adding values. Notice here MyString's add_values method
    # uses addString, not addInt!
    def add_values v 
        v.addString self
    end

    def addInt v # added v is Int
        MyString.new(v.i.to_s + s)
    end

    def addString v # added v is MyString
        MyString.new (v.s + s)
    end

    def addRational v # added v is MyRational
        MyString.new (v.i.to_s + "/" + v.j.to_s + s)
    end
end

class MyRational < Value
    attr_reader :i, :j

    def initialize (i, j)
        @i = i
        @j = j
    end

    def eval 
        self
    end

    def toString
        i.to_s + "/" + j.to_s
    end

    def hasZero  # A string has no zero!
        i==0
    end

    def noNegConstants
        if i < 0 && j < 0
            MyRational.new(-i, -j)
        elsif j < 0
            Negate.new(MyRational.new(i, -j))
        elsif i < 0
            Negate.new(MyRational.new(-i, j))
    end

    # double dispatch for adding values
    def add_values v 
        v.addRational self
    end

    # then define addInt v, addRational v, addString v
    # ...
    def add_values v
        v.addRational self
    end

    def addInt v
        # Recall adding an int to a rational invovles complicated computation. 
        # Simply let addRational handle this.
        v.addRational self 
    end

    def addString v 
        MyString.new(v.s + i.to_s + "/" + j.to_s)
    end

    def addRational v
        MyRational.new(i * v.j + j * v.i, j * v.j)
    end

end
class Int < Value
    attr_reader :i

    def initialize i
        @i = i
    end

    def eval # no argument, because no environment
        self
    end

    def toString
        @i.to_s
    end

    def hasZero 
        i == 0
    end

    def noNegConstants
        if i < 0
            Negate.new(Int.new(-i))
        else
            self
        end
    end

    # The approach of checking what type v is, very common. But this is not really OOP!
    # Don't do this for homework!
    # def add_values v
    #     if v.is_a? Int
    #         Int.new(v.i + i)
    #     elsif v.is_a? MyRational
    #         MyRational.new(v.i + v.j * i, v.j)
    #     else
    #         MyString.new(v.s + i.to_s)
    #     end
    # end

    # Instead, do dynamic dispatch.
    def add_values v # first dispatch
        v.addInt self
    end

    def addInt v # Second dispatch: the added value is an Int
        Int.new(v.i + i)
    end

    def addString v # second dispatch: added value is MyString
        MyString.new(v.s + i.to_s)
    end

    def addRational v # second dispatch: other is Rational
        MyRational.new (v.i + v.j * i, v.j)
    end
end

class Negate < Exp
    attr_reader :e

    def initialize e
        @e = e
    end

    def eval 
        # Error if e.eval has no i method
        Int.new(-e.eval.i)
    end

    def toString
        "-(" + e.toString + ")"
    end

    def hasZero 
        e.hasZero
    end

    def noNegConstants
        Negate.new(e.noNegConstants)
    end
end

class Add < Exp
    attr_reader :e1, :e2

    def initialize (e1, e2)
        @e1 = e1
        @e2 = e2
    end

    def eval 
        # implementation is changed! This time uses add_values helper function
        # Note that only Int and Rationals can have add_values method, so make sure
        # to implement add_values method in Int and Rationals!
        e1.eval.add_values e2.eval
    end

    def toString
        "(" + e.toString + " + " + e2.toString + ")"
    end

    def hasZero 
        e1.hasZero || e2.hasZero
    end

    def noNegConstants
        Add.new(e1.noNegConstants, e2.noNegConstants)
    end
end

# Add a new sub-class, which is the easy part because the structure is similar to
# 'Add' subclass.
class Mult < Exp
    attr_reader :e1, :e2

    def initialize (e1, e2)
        @e1 = e1
        @e2 = e2
    end

    def eval 
        #error if e1.eval or e2.eval has no i method
        Int.new(e1.eval.i * e2.eval.i)
    end

    def toString
        "(" + e.toString + " * " + e2.toString + ")"
    end

    def hasZero 
        e1.hasZero || e2.hasZero
    end

    # The tedious part is adding this noNegConstants function for all
    # the subclasses
    def noNegConstants
        Mult.new(e1.noNegConstants, e2.noNegConstants)
    end
    
end