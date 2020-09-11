import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class ArrayHeapTest {

    /** Basic test of adding, checking, and removing two elements from a heap */
    @Test
    public void simpleTest() {
        ArrayHeap<String> pq = new ArrayHeap<>();
        pq.insert("Qir", 2);
        pq.insert("Kat", 1);
        assertEquals(2, pq.size());

        String first = pq.removeMin();
        assertEquals("Kat", first);
        assertEquals(1, pq.size());

        String second = pq.removeMin();
        assertEquals("Qir", second);
        assertEquals(0, pq.size());
    }

    @Test
    public void changePriorityTest() {
        ArrayHeap<String> pq = new ArrayHeap<>();
        pq.insert("Qir", 2);
        pq.insert("Kat", 6);
        pq.insert("Lol", 4);
        pq.insert("Duh", 3);
        pq.insert("Huh", 5);
        pq.insert("Hey", 8);
        pq.changePriority("Hey", 1);

        /** Remove the node with the least priority, and assign its item to
         * 'removed'. Then compare 'removed' with the expected and see if it's correct.
         */
        String removed = pq.removeMin();
        assertEquals("Hey", removed);

        /** Use 'peek' to see the node with the least priority and get its item.
         * Compare it with the expected value.
         *
         */
        assertEquals("Qir", pq.peek().item());
    }


    public static void main(String[] args) {
        System.exit(ucb.junit.textui.runClasses(ArrayHeapTest.class));
    }
}
