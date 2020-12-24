class Point
    # defines methods x, y, x=, y=
    attr_accessor :x, :y 

    def initialize(x,y)
        @x = x
        @y = y
    end

    # Calculates the distance of the point from origin. Uses instance variables
    def distFromOrigin
        Math.sqrt(@x * @x + @y * @y)
    end

    # This one uses getter methods
    def distFromOrigin2
        # below x and y is like calling self.x and self.y. It's possible to simply use x and y
        # because of the attr_accessor
        Math.sqrt(x * x + y * y)
    end
end

# ColorPoint is a subclass of Point
class ColorPoint < Point
    attr_accessor :color

    def initialize (x, y, c = "clear")
        # calls superclass's initialize
        super(x,y)
        @color = c
    end
    
end

#  EXAMPLES OF USING THE CLASSES ABOVE
p = Point.new(3,4)
cp = ColorPoint.new(53, 95, "red")
p.x # returns p's x
cp.x # returns cp's x
cp.color # returns "red"
# p.color # will return error since p is a Point instance, it doesn't have the color attribute.
p.class # returns Point
cp.class # returns ColorPoint
cp.class.superclass # returns Point
cp.class.superclass.superclass # returns Object

p.is_a? Point # returns true if p is an instance of Point, which is true.
cp.is_a? Point # This returns true! 
cp.is_a? ColorPoint # Also true!
cp.is_a? Object # Also true.

cp.instance_of? Point # false, because cp is an instance of ColorPoint
cp.instance_of? ColorPoint # true