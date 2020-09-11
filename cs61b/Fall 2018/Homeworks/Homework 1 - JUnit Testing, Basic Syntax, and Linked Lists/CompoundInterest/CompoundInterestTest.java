import static org.junit.Assert.*;
import org.junit.Test;

public class CompoundInterestTest {

    @Test
    public void testNumYears() {
        int expected1 = 0;
        int actual1 = CompoundInterest.numYears(2018);
        assertEquals(expected1, actual1);

        int expected2 = 1;
        int actual2 = CompoundInterest.numYears(2019);
        assertEquals(expected2, actual2);

        /** Sample assert statement for comparing integers.

        assertEquals(0, 0);*/
    }

    @Test
    public void testFutureValue() {
        double tolerance = 0.01;
        /**
         * Positive appreciation rates test
         */
        double expected1 = 12.544;
        double actual1 = CompoundInterest.futureValue(10, 12, 2020);
        assertEquals(expected1, actual1, tolerance);

        double expected2 = 10;
        double actual2 = CompoundInterest.futureValue(10, 12, 2018);
        assertEquals(expected2, actual2, tolerance);

        double expected3 = 28.8;
        double actual3 = CompoundInterest.futureValue(20, 20, 2020);
        assertEquals(expected3, actual3, tolerance);

        double expected4 = 2329.80;
        double actual4 = CompoundInterest.futureValue(100, 30, 2030);
        assertEquals(expected4, actual4, tolerance);

        /**
         * Negative appreciation rates test
         */

        double expectedNeg1 = 8.1;
        double actualNeg1 = CompoundInterest.futureValue(10, -10, 2020);
        assertEquals(expectedNeg1, actualNeg1, tolerance);

        double expectedNeg2 = 18.80;
        double actualNeg2 = CompoundInterest.futureValue(100, -13, 2030);
        assertEquals(expectedNeg2, actualNeg2, tolerance);

    }

    @Test
    public void testFutureValueReal() {
        double tolerance = 0.01;

        /**
         * Positive appreciation rates test
         */
        double exp1 = 11.8026496;
        double act1 = CompoundInterest.futureValueReal(10, 12, 2020, 3);
        assertEquals(exp1, act1, tolerance);

        double exp2 = 124.6181934;
        double act2 = CompoundInterest.futureValueReal(100, 10, 2023, 5);
        assertEquals(exp2, act2, tolerance);

        double exp3 = 2335.9675063;
        double act3 = CompoundInterest.futureValueReal(5000, 5, 2040, 8);
        assertEquals(exp3, act3, tolerance);

        /**
         * Negative appreciation rates test
         */

        double exp4 = 7.2863296;
        double act4 = CompoundInterest.futureValueReal(10, -12, 2020, 3);
        assertEquals(exp4, act4, tolerance);

        double exp5 = 45.6909906;
        double act5 = CompoundInterest.futureValueReal(100, -10, 2023, 5);
        assertEquals(exp5, act5, tolerance);

        double exp6 = 258.357767;
        double act6 = CompoundInterest.futureValueReal(5000, -5, 2040, 8);
    }

    @Test
    public void testTotalSavings() {
        double tolerance = 0.01;

        double exp1 = 16550;
        double act1 = CompoundInterest.totalSavings(5000, 2020, 10);
        assertEquals(exp1, act1, tolerance);

        double exp2 = 7598.837181456538101887206322134319104;
        double act2 = CompoundInterest.totalSavings(1000, 2036, -12);
        assertEquals(exp2, act2, tolerance);


        double exp3 = 1448.6562465909833728;
        double act3 = CompoundInterest.totalSavings(100, 2027, 8);
        assertEquals(exp3, act3, tolerance);

    }

    @Test
    public void testTotalSavingsReal() {
        double tolerance = 0.01;

        double exp1 = 15571.895;
        double act1 = CompoundInterest.totalSavingsReal(5000, 2020, 10, 3);
        assertEquals(exp1, act1, tolerance);

        double exp2 = 3644.4276572;
        double act2 = CompoundInterest.totalSavingsReal(1000, 2036, -12, 4);
        assertEquals(exp2, act2, tolerance);

        double exp3 = 913.0147443;
        double act3 = CompoundInterest.totalSavingsReal(100, 2027, 8, 5);
        assertEquals(exp3, act3, tolerance);
    }


    /* Run the unit tests in this file. */
    public static void main(String... args) {
        System.exit(ucb.junit.textui.runClasses(CompoundInterestTest.class));
    }
}
