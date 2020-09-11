import org.junit.Test;
import static org.junit.Assert.*;

public class TestUnionFind {

    @Test
    public void test1(){
        UnionFind a = new UnionFind(10);
        a.union(2, 0);
        /**
         * Check if the size of the set where 2 belongs is 2, and check that
         * the root of 2 is 0.
         */
        assertEquals(2, a.sizeOf(2));
        assertEquals(0, a.find(2));
        a.union(3, 0);
        /**
         * Checks if the size of the set where 3 belongs to is 3, and check
         * that the root of 3 is 0
         */
        assertEquals(0, a.find(3));
        assertEquals(3, a.sizeOf(3));
        /**
         * Checks that the root of 4 is 4, and the size is 1
         */
        assertEquals(4, a.find(4));
        assertEquals(1, a.sizeOf(4));
        /**
         * Checks if 0 and 2 is connected, and 2 and 4 is NOT connected
         */
        assertTrue(a.connected(0, 2));
        assertFalse(a.connected(2, 4));
        /**
         * Checks if the parent of 3 is now 0 after the path compression
         */
        assertEquals(0, a.parent(3));

    }
}
