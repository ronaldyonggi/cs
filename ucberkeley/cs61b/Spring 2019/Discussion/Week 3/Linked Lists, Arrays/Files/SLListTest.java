import static org.junit.Assert.*;
import org.junit.Test;

public class SLListTest {

    @Test
    public void testGetItem(){
        SLList a = new SLList(2);
        a.addFirst(6);
        a.addFirst(5);

        int expected = 5;
        int actual = a.getItem(0);
        assertEquals(expected, actual);

        int expected1 = 6;
        int actual1 = a.getItem(1);
        assertEquals(expected1, actual1);
    }

    @Test
    public void testInsert() {
        SLList a = new SLList(2);
        a.addFirst(6);
        a.addFirst(5);
        a.insert(10, 1);

        int expected = 10;
        int actual = a.getItem(1);
        assertEquals(expected, actual);
    }

    @Test
    public void testReverse() {
        SLList a = new SLList(2);
        a.addFirst(6);
        a.addFirst(5);
        a.reverse();

        int expected = 2;
        int actual = a.getItem(0);
        assertEquals(expected, actual);
    }

    @Test
    public void testReverseRecur() {
        SLList a = new SLList(2);
        a.addFirst(6);
        a.addFirst(5);
        a.reverse();

        int expected = 2;
        int actual = a.getItem(0);
        assertEquals(expected, actual);
    }
}
