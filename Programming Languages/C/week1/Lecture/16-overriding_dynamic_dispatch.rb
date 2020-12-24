
class Point
    attr_accessor :x, :y 

    def initialize(x,y)
        @x = x
        @y = y
    end

    def distFromOrigin
        Math.sqrt(@x * @x + @y * @y)
    end

    def distFromOrigin2
        Math.sqrt(x * x + y * y)
    end
end

class ThreeDPoint < Point
    attr_accessor :z

    # Overrides the initialize method
    def initialize (x, y, z)
        super(x,y)
        @z = z
    end

    # Also override the distFromOrigin method
    def distFromOrigin
        d = super # Calls superclass's distFromOrigin method
        Math.sqrt(d * d + @z * @z)
    end

    def distFromOrigin2
        d = super # Calls superclass's distFromOrigin2 method
        Math.sqrt(d * d + z * z)
    end
end

# In other programming languages, if you don't use the instance variables
# defined in superclass, they still exist but just unused.
# In Ruby, they do not exist. You need to initialize them.
# Thus PolarPoint doesn't have x and y instance variables from Point.
class PolarPoint < Point
    def initialize (r, theta)
        @r = r
        @theta = theta
    end

    def x
        @r * Math.cos(@theta)
    end

    def y
        @r * Math.sin(@theta)
    end

    def x= a
        b = y
        @theta = Math.atan(b / a)
        @r = Math.sqrt (a*a + b*b)
        self
    end

    #define y= b as well

    # must override because PolarPoint doesn't have @x and @y
    def distFromOrigin  
        @r
    end

    # However, don't need to override distFromOrigin2 because
    # now distFromOrigin2 uses the x and y defined above (using @r!)
    
end