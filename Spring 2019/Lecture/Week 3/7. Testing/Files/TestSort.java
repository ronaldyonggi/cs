import org.junit.Test;
import static org.junit.Assert.*;

/** Tests the Sort class */
public class TestSort {
    /** Test the Sort.sort method */
    @Test
    public void testSort() {
        String[] input = {"i", "have", "an", "egg"};
        String[] expected = {"an", "egg", "have", "i"};

        Sort.sort(input);

        assertArrayEquals(expected, input);
    }

    @Test
    public void testFindSmallest() {
        // First Test
        String[] input = {"i", "have", "an", "egg"};
        int expected = 2;

        int actual = Sort.findSmallest(input, 0);
        assertEquals(expected, actual);

        // Second Test

        String[] input2 = {"there", "are", "many", "pigs"};
        int expected2 = 1;

        int actual2 = Sort.findSmallest(input2, 0);
        assertEquals(expected2, actual2);

        // 3rd Test
        String[] input3 = {"there", "are", "many", "pigs"};
        int expected3 = 2;

        int actual3 = Sort.findSmallest(input3, 2);
        assertEquals(expected3, actual3);
    }

    @Test
    public void testSwap() {
        String[] input = {"i", "have", "an", "egg"};
        int a = 0;
        int b = 2;
        String[] expected = {"an", "have", "i", "egg"};

        Sort.swap(input, a, b);
        assertArrayEquals(expected, input);
    }

}