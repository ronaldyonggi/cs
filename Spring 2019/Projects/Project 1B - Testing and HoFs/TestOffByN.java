import org.junit.Test;
import static org.junit.Assert.*;

public class TestOffByN {
    static CharacterComparator offBy4 = new OffByN(4);

    public void testEqualChars() {
        assertTrue(offBy4.equalChars('a', 'd')) ;
        assertTrue(offBy4.equalChars('t', 'q'));
        assertFalse(offBy4.equalChars('a', 'a'));
        assertFalse(offBy4.equalChars('z', 'a'));
    }
}
