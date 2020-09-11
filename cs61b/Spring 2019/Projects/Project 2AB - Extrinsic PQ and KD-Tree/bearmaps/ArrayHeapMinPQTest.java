package bearmaps;

import org.junit.Test;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

public class ArrayHeapMinPQTest {

    @Test
    public void test1(){
        /** Tests add and size.
         *
         */
        ArrayHeapMinPQ<String> x = new ArrayHeapMinPQ<>();
        x.add("Lol", 2);
        x.add("Huh", 1);
        assertEquals(2, x.size());

        /** Tests removeSmallest() and contains().
         *
         */
        String removed = x.removeSmallest();
        assertEquals("Huh", removed);
        assertEquals(1, x.size());
        assertFalse(x.contains("Huh"));

        String removed2 = x.removeSmallest();
        assertEquals("Lol", removed2);
        assertFalse(x.contains("Lol"));
    }

    @Test
    public void test2(){
        /** Tests getSmallest.
         *
         */
        ArrayHeapMinPQ<String> x = new ArrayHeapMinPQ<>();
        x.add("Lol", 3);
        x.add("Huh", 7);
        x.add("Woah", 1);
        x.add("Really?", 12);
        assertEquals("Woah", x.getSmallest());
        assertEquals(4, x.size());

        /** Tests changePriority.
         *
         */
        x.changePriority("Woah", 9);
        assertEquals("Lol", x.getSmallest());
        assertEquals(4, x.size());
    }
}
