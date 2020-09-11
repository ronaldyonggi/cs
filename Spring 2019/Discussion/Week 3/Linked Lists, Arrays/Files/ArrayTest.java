import static org.junit.Assert.*;
import org.junit.Test;

public class ArrayTest {

    @Test
    public void testInsert() {

        int[] x = {5, 9, 14, 15};
        int[] expected = {5, 9, 6, 14, 15};
        int[] actual = Array.insert(x, 6, 2);
        assertArrayEquals(expected, actual);

        int[] expected2 = {0, 5, 9, 14, 15};
        int[] actual2 = Array.insert(x, 0, 0);
        assertArrayEquals(expected2, actual2);

        int[] expected3 = {5, 9, 14, 15, 93};
        int[] actual3 = Array.insert(x, 93, 93);
        assertArrayEquals(expected3, actual3);
    }

    @Test
    public void testReverse(){
        int[] expected = {3, 2, 1};
        int[] actual = {1, 2, 3};
        Array.reverse(actual);
        assertArrayEquals(expected, actual);


        int[] expected2 = {1, 2, 3, 4, 5, 6, 7, 8};
        int[] actual2 = {8, 7, 6, 5, 4, 3, 2, 1};
        Array.reverse(actual2);
        assertArrayEquals(expected2, actual2);
    }

    @Test
    public void testSum() {
        int[] a = {1, 2, 3};
        assertEquals(6, Array.sum(a) );
    }

    @Test
    public void testReplicate() {
        int[] a = {3, 2, 1};
        int[] expected = {3, 3, 3, 2, 2, 1};
        int[] actual = Array.replicate(a);
        assertArrayEquals(expected, actual);
    }
}
