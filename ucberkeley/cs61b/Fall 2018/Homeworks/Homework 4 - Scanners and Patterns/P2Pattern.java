/** Contains the P2 Pattern, no more or less.
 *  @author Josh Hug
 */

public class P2Pattern {
    /** Pattern to match 61b notation for literal IntLists. */
    public static final String P2 = "\\(([0-9]+, +)+[0-9]+\\)"; //FIXME

    /**
     * 1. The first "\\(" indicates the string needs to begin with a "("
     * 2. The [0-9]+, indicates that the pattern covers a sequence of numbers followed by a coma ','
     * 3. The " +" indicates it covers 1 or more whitespaces
     * 4. Notice we enclose the whole expression ([0-9]+, +)+ in parentheses, followed by
     *    a '+'. This means cover 1 or more of a sequence of numbers followed by a coma
     *    and a whitespace.
     *
     *    For example, if our string was
     *    (1, 2, 33, 1, 63)
     *
     *    Then our regEx will cover "(1, 2, 33, 1, "
     *
     * 5. The last "[0-9]+\\(" indicates that the pattern ends with a number followed by an
     *    enclosing parenthesis ')'.
     */
}
