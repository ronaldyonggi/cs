/** A WeirdList holds a sequence of integers.
 * @author
 *
 */
public class WeirdList {

    private int head;
    private WeirdList tail;


    /**
     * The empty sequence of integers.
     *
     * Using the EmptyWeirdList class that we defined at the bottom, it doesn't matter what integer
     * we use for 'head'. Just use a random integer.
     */
    public static final WeirdList EMPTY = new EmptyWeirdList(-100, null);// FILL IN
    // REPLACE THIS LINE WITH THE RIGHT ANSWER.

    /**
     * A new WeirdList whose head is HEAD and tail is TAIL.
     */
    public WeirdList(int head, WeirdList tail) {
        /* FILL IN */
        this.head = head;
        this.tail = tail;
    }

    /**
     * Returns the number of elements in the sequence that
     * starts with THIS.
     */
    public int length() {
        // REPLACE THIS LINE WITH THE RIGHT ANSWER.
        /** Starting with the head (or wherever), calculate the size of the list
         * through recursive call of .length() on the tails until it reaches a null. For every
         * tail found, add the total return value by 1.
         */
        return 1 + this.tail.length();

    }

    /**
     * Part 3b: Apply FUNC.apply to every element of THIS WeirdList in
     * sequence, and return a WeirdList of the resulting values.
     */
    public WeirdList map(IntUnaryFunction func) {
        // REPLACE THIS LINE WITH THE RIGHT ANSWER.
        /** Using recursion technique, apply 'func' to 'this.head' while recursively calling 'map' on this.tail.
         *
         */
        return new WeirdList(func.apply(this.head), this.tail.map(func));
    }


    /**
     * Return a string containing my contents as a sequence of numerals
     * each preceded by a blank.  Thus, if my list contains
     * 5, 4, and 2, this returns " 5 4 2".
     */
    @Override
    public String toString() {
        // REPLACE THIS LINE WITH THE RIGHT ANSWER.
        return " " + this.head + this.tail.toString();
    }

    /*
     * You should not add any methods to WeirdList, but you will need
     * to add private fields (e.g. head).

     * But that's not all!

     * You will need to create at least one additional class for WeirdList
     * to work. This is because you are forbidden to use any of the
     * following in ANY of the code for HW3 (we won't actually check,
     * but, you're depriving yourself of a nice problem if you do):
     *       if, switch, while, for, do, try, or the ?: operator.

     * If you'd like an obtuse hint, scroll to the very bottom of this
     * file.

     * You can create this hypothetical class (or classes) in separate
     * files like you usually do, or if you're feeling bold you can
     * actually stick them INSIDE of this class. Yes, nested classes
     * are a thing in Java.

     * As an example:
     * class Garden {
     *     private static class Potato {
     *        int n;
     *        public Potato(int nval) {
     *           n = nval;
     *        }
     *     }
     * }
     * You are NOT required to do this, just an extra thing you can
     * do if you want to avoid making a separate .java file. */


    /** We can't simply use 'null' to represent WeirdList.EMPTY (if we did, it'll give
     * a NullPointerException Error since the program will try to call the null's 'map'
     * or 'length' or 'toString' method. Instead, create an EmptyWeirdList class that extends
     * WeirdList and has its own method implementations.
     *
     */
    static class EmptyWeirdList extends WeirdList{

        /** EmptyWeirdList constructor. Simply use the super's constructor.
         *
         */
        EmptyWeirdList(int head, WeirdList tail){
            super(head, tail);
        }

        /** When counting the length of a WeirdList, the EmptyWeirdList isn't counted.
         *
         */
        @Override
        public int length(){
            return 0;
        }

        /** For the map function, simply do nothing and return the same 'this' since
         * the EmptyWeirdList isn't going to be displayed anyway.
         *
         */
        @Override
        public WeirdList map(IntUnaryFunction function){
            return this;
        }

        /** For the toString)() function, simply return an
         * empty string (not even whitespace.
         *
         */
        @Override
        public String toString() {
            return "";
        }

    }
}



















    /*
     * Hint: The first non-trivial thing you'll probably do to WeirdList
     * is to fix the EMPTY static variable so that it points at something
     * useful. */

