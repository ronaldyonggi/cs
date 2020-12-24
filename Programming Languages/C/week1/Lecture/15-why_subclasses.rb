# Instead of creating a subclass ColorPoint, might as well
# add the color variable to Point.
class Point
    attr_accessor :color
    def initialize (x, y, c = "clear")
        @x = x
        @y = y
        @color = c
    end
    # However, this would mess up existing users and subclasses of Point
end

# Another alternative is to have ColorPoint as a separate class from 
# Point but with the same methods as Point. However this is bad. 
# Please keep your code DRY

# Another alternative is to use a Point instace variable.
class ColorPoint
    attr_accessor :color

    def initialize (x, y, c = "clear")
        @pt = Point.new(x, y)
        @color = c
    end

    def x
        @pt.x
    end

    # ...and define other methods for y, x=, y=
    
end