/**
 * TestArrayDequeGold class for Project 1 Gold
 * @author Ronald Yonggi
 */
import static org.junit.Assert.*;
import org.junit.Test;
public class TestArrayDequeGold {
    StudentArrayDeque<Integer> sad = new StudentArrayDeque<>();
    ArrayDequeSolution<Integer> ads = new ArrayDequeSolution<>();

    @Test
    public void testMethods() {
        String message = "\n";
        for (int i = 0; i < 7; i++) {
            double randomized = StdRandom.uniform();

            if(randomized < 0.5) {
                sad.addLast(i);
                ads.addLast(i);
                message = message.concat(String.format("addLast(%d)\n", i));
            } else {
                sad.addFirst(i);
                ads.addFirst(i);
                message = message.concat(String.format("addFirst(%d)\n", i));
            }
        }
        message = message.concat("removeFirst()\n");
        assertEquals(message, sad.removeFirst(), ads.removeFirst());
        message = message.concat("removeLast()");
        assertEquals(message, sad.removeLast(), ads.removeLast());

    }


}
