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

    @Test
    public void testReverseNondestructive() {
        /** Normal Test */
        IntList original = IntList.list(0, 1, 2, 3, 4, 5, 6);
        IntList exp1 = IntList.list(6, 5, 4, 3, 2, 1, 0);
        IntList act1 = IntList.reverseNondestructive(original);
        assertEquals(exp1, act1);

        /* Check if the original is unchanged */
        IntList unchanged = IntList.list(0, 1, 2, 3, 4, 5, 6);
        assertEquals(unchanged, original);
    }

    @Test
    public void testInsert() {
        /** Normal Test */
        IntList original = IntList.list(0, 1, 2, 4, 5, 6);
        IntList exp1 = IntList.list(0, 1, 2, 3, 4, 5, 6);
        IntList act1 = IntList.insert(original, 3, 3);
        assertEquals(exp1, act1);

        /** Test if position is greater than length of IntList */
        IntList ori1 = IntList.list(0, 1, 2, 3);
        IntList exp2 = IntList.list(0, 1, 2, 3, 4);
        IntList act2 = IntList.insert(ori1, 4, 99);
        assertEquals(exp2, act2);
    }

    @Test
    public void testShiftListDestructive() {
        /** Normal Test */
        IntList original = IntList.list(5, 1, 2, 3, 4);
        IntList expected = IntList.list(1, 2, 3, 4, 5);
        IntList actual = IntList.shiftListDestructive(original);
        assertEquals(expected, actual);

    }


    /* Run the unit tests in this file. */
    public static void main(String... args) {
        System.exit(ucb.junit.textui.runClasses(IntListTest.class));
    }
}
