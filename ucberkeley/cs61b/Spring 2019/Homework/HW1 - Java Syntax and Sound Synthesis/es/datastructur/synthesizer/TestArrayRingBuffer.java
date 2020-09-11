package es.datastructur.synthesizer;
import org.junit.Test;
import static org.junit.Assert.*;

/** Tests the ArrayRingBuffer class.
 *  @author Josh Hug
 */

public class TestArrayRingBuffer {
    @Test
    public void someTest() {
        ArrayRingBuffer arb = new ArrayRingBuffer(10);
        assertEquals(arb.capacity(), 10);
        arb.enqueue(5);
        arb.enqueue(12);
        assertEquals(arb.dequeue(), 5);
        assertEquals(arb.peek(), 12);
    }

    @Test
    public void testIteratorEquals() {
        ArrayRingBuffer arb = new ArrayRingBuffer(10);
        ArrayRingBuffer arbOther = new ArrayRingBuffer(10);
        for (int i  = 0; i < arb.capacity(); i++) {
            arb.enqueue(i);
            arbOther.enqueue(i);
        }
        assertTrue(arb.equals(arbOther));
        arb.dequeue();
        arbOther.dequeue();
        assertTrue(arbOther.equals(arb));
    }

}
