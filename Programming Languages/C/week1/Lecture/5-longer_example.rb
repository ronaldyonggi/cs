# Instances of MyRational represents fractions
class MyRational
    
    # Initialize with numerator and denominator
    def initialize(num, den=1) 
        if den == 0
            raise "Denominator can't be 0!"
        elsif den < 0
            @num = -num
            @den = -den
        else
            @num = num
            @den = den
        end
        # calls the private reduce method
        reduce
    end

    # to_string method
    def to_s
        ans = @num.to_s
        if @den != 1
            ans += "/"
            ans += @den.to_s
        end
        ans #return ans
    end

    # alternative version of to_string
    def to_s2
        dens = ""
        # The line below is only executed if it fulfills the if condition
        dens = "/" + @den.to_s if @den != 1

        # Return the result
        @num.to_s + dens
    end

    # even another alternative version of to_string
    def to_s3
        "#{@num}#{if @den==1 then "" else "/" + @den.to_s end}"
    end

    def add! r #convention is to use '!' if mutation involved.
        a = r.num
        b = r.den
        # Above, need to use getter because we can't
        # directly call r.@num. Remember @... are private!
        c = @num
        d = @den
        @num = (a*d) + (b*c)
        @den = b*d
        reduce
        self #at the end, return the object itself
    end

    # A functional addition (syntactic sugar) so
    # we can use r1.+r2. And turns out built-in ruby feature
    # make it better: can use r1 + r2
    def + r
        ans = MyRational.new(@num, @den)
        ans.add! r
        ans
    end

    protected
    # There is a shorter way of doing this:
    # attr_reader :num, :den
    # protected :num, :den
    def num
        @num
    end

    def den
        @den
    end

    @private

    def gcd(x, y)
        if x == y
            x
        elsif x < y
            gcd(x, y-x)
        else
            gcd(y,x)
        end
    end

    def reduce
        if @num == 0
            @den = 1
        else
            d = gcd(@num.abs, @den) # d is common denominator
            @num = @num / d
            @den = @den / d
        end
    end
end

# A function that can be used to test the rationals
def test_rationals
    r1 = MyRational.new(3, 4)
    r2 = r1 + r1 + MyRational.new(-5,2)
    puts r2.to_s
    (r2.add! r1).add! (MyRational.new(1,-4))
    puts r2.to_s
    puts r2.to_s2
    puts r2.to_s3
end

test_rationals # call the test function!