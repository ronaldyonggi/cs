class A
    def m1
        34
    end

    def m2 (x, y) # this method takes 2 arguments, x and y
        z = 7
        if x > y
            false
        else
            x + y * z
        end
    end
end

a = A.new # assign an instance of A to variable a
puts a.m1 # prints the result of calling a.m1. If we don't use puts, it only returns the result but doesn't print it
puts a.m2(3,4)

class B
    def m1
        4
    end

    def m3 x
        x.abs * 2 + self.m1
    end
end

b = B.new
puts b.m3(-1)

class C
    def m1
        print "hi"
        self
    end

    def m2
        print "bye"
        self
    end

    def m3
        print "lol"
        self
    end
end

c = C.new
# Notice in m1, m2, m3 that all these methods return self. This self this the instance c. Thus,
# calling c.m1.m2 is like calling (c.m1).m2, and (c.m1) returns the instance c!
print c.m1.m2.m3.m1.m2