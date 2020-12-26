
class Pt
    attr_accessor :x, :y
    def distToOrigin
        Math.sqrt(x * x + y * y)
    end
end

class ColorPt < Pt
    attr_accessor :color
    def darken # error if @color not already set
        self.color = "dark " + self.color
    end
end

class Pt3D < Pt
    attr_accessor :z
    def distToOrigin
        Math.sqrt(x * x + y * y + z * z)
    end
end

# It would be nice if we can inherit from 2 classes at once, unfortunately
# Ruby doesn't allow this. C++ allows this.
# class ColorPt3D_3 < ColorPt, Pt3d
# end

# The following are 2 ways we can make 3D Color points
# 1. Make a 3D subcclass from ColorPt
class ColorPt3D_1 < ColorPt
    attr_accessor :z
    def distToOrigin
        Math.sqrt(x * x + y * y + z * z)
    end
end

# Or 2. Make a Colored subclass from Pt3D
class ColorPt3D_2 < Pt3D
    attr_accessor :color
    def darken # error if @color not already set
        self.color = "dark " + self.color
    end
end