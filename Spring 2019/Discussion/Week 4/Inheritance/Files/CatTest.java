import static org.junit.Assert.*;
import org.junit.Test;

public class CatTest {

    @Test
    public void testGreet() {
        Cat a = new Cat("Connie", 6);
        a.greet();
    }
}
