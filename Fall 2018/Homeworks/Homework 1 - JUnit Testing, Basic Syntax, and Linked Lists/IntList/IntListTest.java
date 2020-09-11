import static org.junit.Assert.*;
import org.junit.Test;

public class IntListTest {

    /** Sample test that verifies correctness of the IntList.list static
     *  method. The main point of this is to convince you that
     *  assertEquals knows how to handle IntLists just fine.
     */

    @Test
    public void testList() {
        IntList one = new IntList(1, null);
        IntList twoOne = new IntList(2, one);
        IntList threeTwoOne = new IntList(3, twoOne);

        IntList x = IntList.list(3, 2, 1);
        assertEquals(threeTwoOne, x);
    }

    /** Do not use the new keyword in your tests. You can create
     *  lists using the handy IntList.list method.
     *
     *  Make sure to include test cases involving lists of various sizes
     *  on both sides of the operation. That includes the empty list, which
     *  can be instantiated, for example, with
     *  IntList empty = IntList.list().
     *
     *  Keep in mind that dcatenate(A, B) is NOT required to leave A untouched.
     *  Anything can happen to A.
     */

    @Test
    public void testDcatenate() {

        IntList empty = IntList.list();
        IntList oneTwo = IntList.list(1, 2);
        IntList exp1 = oneTwo;
        IntList act1 = IntList.dcatenate(empty, oneTwo);
        assertEquals(exp1, act1);

        IntList threeFour = IntList.list(3, 4);
        IntList exp2 = IntList.dcatenate(oneTwo, threeFour);
        IntList act2 = IntList.list(1, 2, 3, 4);
        assertEquals(exp2, act2);

    }

    /** Tests that subtail works properly. Again, don't use new.
     *
     *  Make sure to test that subtail does not modify the list.
     */

    @Test
    public void testSubtail() {

        /** Normal Test */
        IntList ori = IntList.list(1, 2, 3, 4); // ori stands for original
        IntList exp1 = IntList.list(2, 3, 4);
        IntList act1 = IntList.subTail(ori, 1);
        assertEquals(exp1, act1);

        /** Test if start is 0 */
        assertEquals(ori, IntList.subTail(ori, 0));

        /** Test if start is greater than the length of provided IntList */
        IntList exp3 = null;
        assertEquals(exp3, IntList.subTail(ori, 100));

        /** Test if the start is invalid (e.g. negative integer) */
        assertEquals(null, IntList.subTail(ori, -1));

        /** Check whether ori is mutated */
        IntList unchanged = IntList.list(1, 2, 3, 4);
        assertEquals(unchanged, ori);
    }

    /** Tests that sublist works properly. Again, don't use new.
     *
     *  Make sure to test that sublist does not modify the list.
     */

    @Test
    public void testSublist() {


        /** Normal Test */
        IntList original = IntList.list(0, 1, 2, 3, 4, 5, 6);
        IntList exp1 = IntList.list(3, 4);
        IntList act1 = IntList.sublist(original, 3, 2);
        assertEquals(exp1, act1);

        /** Test if len is 1 */
        IntList exp2 = IntList.list(4);
        IntList act2 = IntList.sublist(original, 4, 1);
        assertEquals(exp2, act2);

        /** Test if the original is unchanged */
        IntList unchanged = IntList.list(0, 1, 2, 3, 4, 5, 6);
        assertEquals(unchanged, original);

    }

    /** Tests that dSublist works properly. Again, don't use new.
     *
     *  As with testDcatenate, it is not safe to assume that list passed
     *  to dSublist is the same after any call to dSublist
     */

    @Test
    public void testDsublist() {
        /** Normal Test */
        IntList original = IntList.list(0, 1, 2, 3, 4, 5, 6);
        IntList exp1 = IntList.list(3, 4);
        IntList act1 = IntList.dsublist(original, 3, 2);
        assertEquals(exp1, act1);

        /** Test if the original is changed */
        IntList exp2 = IntList.list(0, 1, 2, 3, 4, 5, 6);
        assertNotEquals(exp2, original);
    }


    /* Run the unit tests in this file. */
    public static void main(String... args) {
        System.exit(ucb.junit.textui.runClasses(IntListTest.class));
    }
}
