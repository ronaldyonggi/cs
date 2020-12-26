class Exp
    # could put default implementations or helper methods here
end

class Value < Exp
    # overkill, but useful if you have multiple kinds
    # of values in language that can share methods that don't 
    # make sense for non-value expressions.
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

    # Need to add noNegConstants function to each subclasses :(
    def noNegConstants
        if i < 0
            Negate.new(Int.new(-i))
        else
            self
        end
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
        #error if e1.eval or e2.eval has no i method
        Int.new(e1.eval.i + e2.eval.i)
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