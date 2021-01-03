# University of Washington, Programming Languages, Homework 7, hw7.rb 
# (See also ML code)

# a little language for 2D geometry objects

# each subclass of GeometryExpression, including subclasses of GeometryValue,
#  needs to respond to messages preprocess_prog and eval_prog
#
# each subclass of GeometryValue additionally needs:
#   * shift
#   * intersect, which uses the double-dispatch pattern
#   * intersectPoint, intersectLine, and intersectVerticalLine for 
#       for being called by intersect of appropriate clases and doing
#       the correct intersection calculuation
#   * (We would need intersectNoPoints and intersectLineSegment, but these
#      are provided by GeometryValue and should not be overridden.)
#   *  intersectWithSegmentAsLineResult, which is used by 
#      intersectLineSegment as described in the assignment
#
# you can define other helper methods, but will not find much need to

# Note: geometry objects should be immutable: assign to fields only during
#       object construction

# Note: For eval_prog, represent environments as arrays of 2-element arrays
# as described in the assignment

class GeometryExpression  
  # do *not* change this class definition
  Epsilon = 0.00001
end

class GeometryValue 
  # do *not* change methods in this class definition
  # you can add methods if you wish

  private
  # some helper methods that may be generally useful
  def real_close(r1,r2) 
    (r1 - r2).abs < GeometryExpression::Epsilon
  end
  def real_close_point(x1,y1,x2,y2) 
    real_close(x1,x2) && real_close(y1,y2)
  end
  # two_points_to_line could return a Line or a VerticalLine
  def two_points_to_line(x1,y1,x2,y2) 
    if real_close(x1,x2)
      VerticalLine.new x1
    else
      m = (y2 - y1).to_f / (x2 - x1)
      b = y1 - m * x1
      Line.new(m,b)
    end
  end

  public
  # we put this in this class so all subclasses can inherit it:
  # the intersection of self with a NoPoints is a NoPoints object
  def intersectNoPoints np
    np # could also have NoPoints.new here instead
  end

  # we put this in this class so all subclasses can inhert it:
  # the intersection of self with a LineSegment is computed by
  # first intersecting with the line containing the segment and then
  # calling the result's intersectWithSegmentAsLineResult with the segment
  def intersectLineSegment seg
    line_result = intersect(two_points_to_line(seg.x1,seg.y1,seg.x2,seg.y2))
    line_result.intersectWithSegmentAsLineResult seg
  end

end

class NoPoints < GeometryValue
  # do *not* change this class definition: everything is done for you
  # (although this is the easiest class, it shows what methods every subclass
  # of geometry values needs)
  # However, you *may* move methods from here to a superclass if you wish to

  # Note: no initialize method only because there is nothing it needs to do
  def eval_prog env 
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end
  def shift(dx,dy)
    self # shifting no-points is no-points
  end

  # Double dispatch: tell the 'other' object to call its intersectNoPoints 
  # method with self (a NoPoint) as the argument.
  def intersect other
    other.intersectNoPoints self # will be NoPoints but follow double-dispatch
  end
  def intersectPoint p
    self # intersection with point and no-points is no-points
  end
  def intersectLine line
    self # intersection with line and no-points is no-points
  end
  def intersectVerticalLine vline
    self # intersection with line and no-points is no-points
  end
  # if self is the intersection of (1) some shape s and (2) 
  # the line containing seg, then we return the intersection of the 
  # shape s and the seg.  seg is an instance of LineSegment
  def intersectWithSegmentAsLineResult seg
    self
  end
end


class Point < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods

  # Note: You may want a private helper method like the local
  # helper function inbetween in the ML code
  attr_reader :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end

  # The shift method creates a new object, not mutating self.
  def shift(dx, dy)
    Point.new(x+dx, y+dy)
  end

  # Double dispatch: tell the other object to call its intersectPoint method with self (a point)
  # as the argument.
  def intersect other
    other.intersectPoint self
  end

  # Don't need to define intersectNoPoints method since already 
  # inherited from superclass.

  def intersectPoint p
    # If the coordinates of self with point p are really close, return
    # either one.
    if real_close_point(@x, @y, p.x, p.y)
      self # In this case simply return self.
    # Otherwise the points don't intersect. Return NoPoint
    else NoPoints.new 
  end

    # Can check whether a point intersects a line by inputting point's x into
    # line's equation (mx + b) and see if the result is equal (or really close to)
    # point's y.
  def intersectLine line
    if real_close(@y, line.m * @x + line.b)
      self
    else NoPoints.new
  end

  # Checking if a point intersects a vertical line is easier: just compare the x coordinates!
  def intersectVerticalLine vline
    if real_close(@x, vline.x)
      self
    else NoPoints.new
  end

  # Refer to sml code on how to handle LineSegment paired with a Point.
  def intersectWithSegmentAsLineResult seg
    if inbetween(@x, p.x1, p.x2) && inbetween(@y, p.y1, p.y2)
      p
    else
      NoPoints.new
  end

  # Helper inbetween method, used for intersectWithSegmentAsLineResult method.
  # Refer to inbetween function in SML version.
  private
  def inbetween(v, end1, end2)
    eps = GeometryExpression:: Epsilon
    first_req = (end1 - eps <= v) && (v <= end2 + eps)
    second_req = (end2 - eps <= v) && (v <= end1 + eps)
    first_req || second_req
  end
end

class Line < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  attr_reader :m, :b 
  def initialize(m,b)
    @m = m
    @b = b
  end

  # Line's shift method creates a new object, not mutating self.
  def shift(dx, dy)
    Line.new(@m, @b+dy - (@m * dx))
  end

  # Double dispatch: call other's intersectLine method.
  def intersect other
    other.intersectLine self
  end

  # Don't need to implement intersectNoPoints, already inherited from superclass

  # Commutative: recall we already defined Point's intersectLine method. Here we can just
  # call p's intersectLine on self.
  def intersectPoint p
    p.intersectLine self
  end

  def intersectLine line
    if real_close(@m, line.m)
      # If both the slope and intercept are the same, then these are the same line!
      if real_close (@b, line.b)
        self
      # Otherwise if only the slopes are the same, then they are parallel lines (no intersection).
      else NoPoints.new
      end
    # Otherwise the 2 lines will intersect at a point.
    else
      x = (line.b - @b) / (@m - line.m)
      y = @m * x + @b
      Point.new(x, y)
  end

  # A line and a vertical line intersects at a point. The y-coordinate of the point can be computed
  # by inputting the vertical line's x into the equation of the line.
  def intersectVerticalLine vline
    Point(vline.x, @m * vline.x + @b)
  end

  # Problem statement says that assumes `self` is the intersection of a geometry-value and 
  # the line CONTAINING the segment given. Thus here we can simply return the segment
  # as part of the line.
  def intersectWithSegmentAsLineResult seg
    seg
  end

end

class VerticalLine < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  attr_reader :x
  def initialize x
    @x = x
  end

  # Even though we only use dx, the signature for shift method still need to have both
  # dx and dy as arguments.
  def shift(dx, dy)
    VerticalLine.new(@x + dx)
  end

  # Double dispatch: simply call other's intersectVerticalLine method.
  def intersect other
    other.intersectVerticalLine self
  end

  # Commutative: we already defined Point's intersectVerticalLine method.
  # Just call p's intersectVerticalLine on self.
  def intersectPoint p
    p.intersectVerticalLine self
  end

  # Commutative: we already defined Line's intersectVerticalLine method.
  # Just call line's intersectVerticalLine on self.
  def intersectLine line
    line.intersectVerticalLine self
  end

  def intersectVerticalLine vline
    if real_close(@x, vline.x)
      then self
    else NoPoints.new
  end

  # Problem statement says that assumes `self` is the intersection of a geometry-value and 
  # the line (VERTICAL OR NOT) CONTAINING the segment given. Thus here we can simply return the segment
  # as part of the line.
  def intersectWithSegmentAsLineResult seg
    seg
  end

end

class LineSegment < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  # Note: This is the most difficult class.  In the sample solution,
  #  preprocess_prog is about 15 lines long and 
  # intersectWithSegmentAsLineResult is about 40 lines long
  attr_reader :x1, :y1, :x2, :y2
  def initialize (x1,y1,x2,y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def shift(dx, dy)
    LineSegment.new(x1+dx, y1+dy, x2+dx, y2+dy)
  end

  # Double dispatch: simply call other's intersectWithSegmentAsLineResult method.
  def intersect other
    other.intersectWithSegmentAsLineResult self
  end

  # Commutative: We already defined Point's intersectWithSegmentAsLineResult method.
  def intersectPoint p
    p.intersectWithSegmentAsLineResult self
  end

  # Commutative: Already defined Line's intersectwithSegmentAsLineResult method.
  def intersectLine line
    line.intersectwithSegmentAsLineResult self
  end

  # Commutative: Already defined VerticalLine's intersectwithSegmentAsLineResult method.
  def intersectLine vline
    vline.intersectwithSegmentAsLineResult self
  end

end

# Note: there is no need for getter methods for the non-value classes

class Intersect < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end

  # Here the preprocess_prog method is added.
  def preprocess_prog
    Intersect.new(@e1.preprocess_prog, @e2.preprocess_prog)
  end

  def eval_prog env
    e1_evaluated = @e1.eval_prog(env)
    e2_evaluated = @e2.eval_prog(env)
    e1_evaluated.intersect(e2_evaluated)
  end
  
end

class Let < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  # Note: Look at Var to guide how you implement Let
  def initialize(s,e1,e2)
    @s = s
    @e1 = e1
    @e2 = e2
  end

  def preprocess_prog
    Let.new(@s, @e1.preprocess_prog, @e2.preprocess_prog)
  end

  def eval_prog env
    # First evaluate e1 within the provided environment env
    e1_evaluated = @e1.eval_prog(env)
    # Then update current environment so that now we have @s bound to e1_evaluated
    updated_env = [[@s, e1_evaluated]] + env
    # Finally evaluate @e2 within the updated environment.
    @e2.eval_prog(updated_env)
  end
end

class Var < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize s
    @s = s
  end
  def eval_prog env # remember: do not change this method
    pr = env.assoc @s
    raise "undefined variable" if pr.nil?
    pr[1]
  end
  
  # No expression is involved, so simply return self
  # for preprocess_prog
  def preprocess_prog
    self
  end
end

class Shift < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(dx,dy,e)
    @dx = dx
    @dy = dy
    @e = e
  end

  # Added preprocess_prog method
  def preprocess_prog
    Shift.new(@dx, @dy, @e.preprocess_prog)
  end

  # Every subclass of GeometryValue has a shift method, thus eval_prog for
  # this Shift class will be easy: simply call the expression's shift method.
  def eval_prog env
    @e.eval_prog(env).shift(@dx, @dy)
  end
end
