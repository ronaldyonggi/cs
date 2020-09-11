package hw3.hash;
import java.awt.Color;
import edu.princeton.cs.algs4.StdRandom;
import edu.princeton.cs.algs4.StdDraw;


public class SimpleOomage implements Oomage {
    protected int red;
    protected int green;
    protected int blue;

    private static final double WIDTH = 0.01;
    private static final boolean USE_PERFECT_HASH = true;

    @Override
    public boolean equals(Object o) {
        /** If the input object is null, then obviously it's false.
         *
         */
        if (o == null) return false;
        /** If the class of the input object is not the same as
         * 'this''s class, then it can't be equal.
         */
        if (o.getClass() != this.getClass()) return false;
        /** If the input object is the same as 'this', then it has
         * to be equal.
         */
        if (o == this) return true;
        /** Otherwise, compare each of the instance variables. If they are all
         * the same, then they have to be equals.
         */
        SimpleOomage that = (SimpleOomage) o;
        return (this.red == that.red) && (this.green == that.green) && (this.blue == that.blue);
    }

    @Override
    public int hashCode() {
        if (!USE_PERFECT_HASH) {
            return red + green + blue;
        } else {
            /** An easy hashCode implementation for RGB is as the following:
             * 1. Set blue to be a representation of integer up to hundreds ( 0 - 255)
             * 2. Set green to be a representation of integer from thousands up to hundreds thousands
             * (000000 to 255000)
             * 3. Set red to be a representation of integer from hundreds thousands to hundreds millions)
             * (000000000 to 255000000)
             *
             * At the end, we divide the result by 5. If we didn't do this and we try to assign the hashCode to 10 buckets or 100
             * buckets or multiple of 10, the spread will be uneven since the resulting hashCode would be % 10, which would be either
             * 5 or 0. In this case, most of the oomages will be in bucket 5 and 0.
             */

            return ((red * 1000000) + (green * 1000) + blue) / 5;
        }
    }

    public SimpleOomage(int r, int g, int b) {
        if (r < 0 || r > 255 || g < 0 || g > 255 || b < 0 || b > 255) {
            throw new IllegalArgumentException();
        }
        if ((r % 5 != 0) || (g % 5 != 0) || (b % 5 != 0)) {
            throw new IllegalArgumentException("red/green/blue values must all be multiples of 5!");
        }
        red = r;
        green = g;
        blue = b;
    }

    @Override
    public void draw(double x, double y, double scalingFactor) {
        StdDraw.setPenColor(new Color(red, green, blue));
        StdDraw.filledSquare(x, y, WIDTH * scalingFactor);
    }

    public static SimpleOomage randomSimpleOomage() {
        int red = StdRandom.uniform(0, 51) * 5;
        int green = StdRandom.uniform(0, 51) * 5;
        int blue = StdRandom.uniform(0, 51) * 5;
        return new SimpleOomage(red, green, blue);
    }

    public static void main(String[] args) {
        System.out.println("Drawing 4 random simple Oomages.");
        randomSimpleOomage().draw(0.25, 0.25, 1);
        randomSimpleOomage().draw(0.75, 0.75, 1);
        randomSimpleOomage().draw(0.25, 0.75, 1);
        randomSimpleOomage().draw(0.75, 0.25, 1);
    }

    public String toString() {
        return "R: " + red + ", G: " + green + ", B: " + blue;
    }
} 
