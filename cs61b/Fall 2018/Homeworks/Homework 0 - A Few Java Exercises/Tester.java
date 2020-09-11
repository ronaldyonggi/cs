import org.junit.Test;
import static org.junit.Assert.*;

import ucb.junit.textui;

/** Tests for hw0.
 *  @author YOUR NAMES HERE
 */
public class Tester extends Homework0 {

    /* Feel free to add your own tests.  For now, you can just follow
     * the pattern you see here.  We'll look into the details of JUnit
     * testing later.
     *
     * To actually run the tests, just use
     *      java Tester
     * (after first compiling your files).
     *
     * DON'T put your HW0 solutions here!  Put them in a separate
     * class and figure out how to call them from here.  You'll have
     * to modify the calls to max, threeSum, and threeSumDistinct to
     * get them to work, but it's all good practice! */

    @Test
    public void maxTest() {
        // Change call to max to make this call yours.
        assertEquals(14, forMax(new int[] { 0, -5, 2, 14, 10 }));
        assertEquals(6, forMax(new int[] { 2, 3, 4, 5, 6 }));
        assertEquals(98, forMax(new int[] { 7, -3, 12, 16, 98 }));
        assertEquals(1, forMax(new int[] {1}));
        // REPLACE THIS WITH MORE TESTS.
    }

    @Test
    public void threeSumTest() {
        // Change call to threeSum to make this call yours.
        assertTrue(threeSum(new int[] { -6, 3, 10, 200 }));
        assertTrue(threeSum(new int[] { 4, 3, -7, 2, 1, -3}));
        assertFalse(threeSum(new int[] { 5, 3, 1, 2, 6}));
        // REPLACE THIS WITH MORE TESTS.
    }

    @Test
    public void threeSumDistinctTest() {
        // Change call to threeSumDistinct to make this call yours.
        assertFalse(threeSumDistinct(new int[] { -6, 3, 10, 200 }));
        assertTrue(threeSumDistinct(new int[] {-6, 6, 0, 10}));
        assertTrue(threeSumDistinct(new int[] {-6, 3, 3, 2}));
        assertFalse(threeSumDistinct(new int[] { -6, 2, 5 }));
        assertTrue(threeSumDistinct(new int[] { 8, 2, -1, -1, 15 }));
        assertFalse(threeSumDistinct(new int[] { 5, 1, 0, 3, 6 }));
        // REPLACE THIS WITH MORE TESTS.
    }

    public static void main(String[] unused) {
        textui.runClasses(Tester.class);
    }

}
