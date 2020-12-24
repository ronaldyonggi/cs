class Foo
    def initialize(max)
        @max = max
    end

    # This silly function takes in a block! If we don't provide a block, it
    # will give error.
    def silly
        yield (4,5) + yield (@max, @max)
    end

    def count base
        if base > @max
            raise "reached max"
        elsif yield base
            1 
        else
            1 + (count (base+1) {|i| yield i})
        end
    end
    
end

f = Foo.new(1000)

f.silly  {|a,b| 2 * a - b}
# Will return 1003 because 
# 1. yield (4,5) -> 2*4 - 5 = 3
# 2. yield (1000, 1000) -> 2*1000 - 1000 = 1000
# 3. Thus 3 + 1000 = 1003

f.count(10) {|i| (i*i) == (34*i)} # Returns 25.
# starting with 10, ruby calculates 10 * 10 and checks if that's equal to 34 * 10
# if not, then return 1 + the recursive calculation, with 11 instead of 10 (+1 for each recursive call).

# The 25 is how many times, from base 10, that the recursive call is called until the condition
# in the block is fulfiled. This makes sense because at count 24, the base should be 10+24 = 34, thus
# 34 * 34 == 34 * 34.
