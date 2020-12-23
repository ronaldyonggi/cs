class A
    def m1
        # @foo is an object state, a.k.a. instance variables
        @foo = 0
    end

    def m2 x
        @foo += x
    end

    def foo
        @foo
    end
end

x = A.new
y = A.new
z = x
# x and z are the same object. x and y are different.

x.m1 # instantiates an instance variable foo and set it to 0
z.m2 10 # this foo instance is also part of z, so z can also modify this foo.
puts x.foo

y.foo # x and z's foo are different from y's foo.

# Notice above that we need to call m1 to instantiate foo. Below is a class definition that
# when created, also automatically creates the foo instance.

class B
    # initialize is a special method that gets executed when an instance of B is created.
    # Here we set default argument to 0.
    def initialize(f=0)
        @foo = f
    end

    def m1
        @foo = 0
    end

    def m2 x
        @foo += x
    end

    def foo
        @foo
    end
end

q = B.new 3
puts q.foo

class C
    # Below is a class constant. Can be called
    # outside class by C::Dans_Age
    Dans_Age = 38

    # Below, the method uses the 'self' keyword. This is a class method,
    # Use with C.reset_bar instead of 'instance of C'.reset_bar
    def self.reset_bar
        # @@bar is a class variable, shared by all instances 
        # of the class C
        @@bar = 0 
    end

    def initialize(f=0)
        @foo = f
    end

    def m2 x
        @foo += x
        @@bar += 1
    end

    def foo
        @foo
    end
    
    def bar
        @@bar
    end
end

puts C::Dans_Age # Prints Dans_Age