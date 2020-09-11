package quiz;

public class RuntimeQuiz {
    /** Asymptotic notations **/
    public enum Asymptotic { BIG_O, BIG_THETA, BIG_OMEGA }
    /** Functions describing runtime **/
    public enum Runtime { // Assuming n is the length of the input
        CONSTANT,     // 1
        LOG_N,        // log(n)
        LINEAR,       // n
        LINEARITHMIC, // n * log(n)
        QUADRATIC,    // n^2
        CUBIC,        // n^3
        EXPONENTIAL   // a^n where a is any constant
    }

    /**
     * Fill out the missing Asymptotic and Runtime values according to the
     * asymptotic behavior of each method. Give the tightest bound you can.
     * f1() is given as an example - with notation and function together, it is in Theta(N),
     * where N is the length of the input array.
     */

    /** Explanation: Even though the nested j iterates through a huge number (Integer.MAX_VALUE),
     * Integer.MAX_VALUE is a constant number. Therefore, we only care about the 'i' iteration.
     */
    public static Asymptotic f1_notation = Asymptotic.BIG_THETA;
    public static Runtime f1_runtime = Runtime.LINEAR;
    public void f1(int[] array) {
        for (int i = 0; i < array.length; i++) {
            for (int j = 0; j < Integer.MAX_VALUE; j++) {
                System.out.println("Hi!");
            }
        }
    }

    /** Explanation: in the return statement, we only need to pay attention at the recursive
     * call f2(n-1).
     *
     * If we analyze the total number of work involved:
     *
     * N + N-1 + N-2 +  N-3 + N-4 + N-5 + ...
     *
     * Which can be described strictly as N^2. Think of area of a triangle.
     *
     *
     */
    public static Asymptotic f2_notation = Asymptotic.BIG_THETA;
    public static Runtime f2_runtime = Runtime.QUADRATIC;
    public int f2(int n) {
        if (n <= 1) return n;
        f1(new int[n]);
        return n + n * f2(n - 1) + n * n * f2(1);
    }

    /**
     * Explanation:
     * This is similar to mitosis branching.
     *
     *
     *                N
     *              /   \
     *             /     \
     *            /       \
     *           N/2       N/2
     *           /\        /\
     *          /  \      /  \
     *         /    \    /    \
     *         N/4  N/4 N/4 N/4
     *
     * If we start at N and half the problem each time. It'll take log(N) steps to reduce
     * down to 1. Plugging to the formula, we have 2^(log N), which simplifies to N. Therefore,
     * the runtime is Theta(N).
     *
     */
    public static Asymptotic f3_notation = Asymptotic.BIG_THETA;
    public static Runtime f3_runtime = Runtime.LINEAR;
    /* When f3 is first called, start will be 0 and end will be the length of the array - 1 */
    public int f3(char[] array, int start, int end) {
        if (array.length <= 1 || end <= start) return 1;
        int mid = start + ((end - start) / 2);
        return f3(array, start, mid) + f3(array, mid + 1, end);
    }

    /** Explanation: During the first iteration, the for loop iterate through the whole array. Thus
     * we know that at the very least, the runtime can't get any better than N.
     *
     * The recursive branching is similar to the previous problem. As the height of the branching is
     * roughly log N, the runtime is then Theta (N log N).
     */
    public static Asymptotic f4_notation = Asymptotic.BIG_THETA;
    public static Runtime f4_runtime = Runtime.LINEARITHMIC;
    /* When f4 is first called, start will be 0 and end will be the length of the array - 1 */
    public int f4(char[] array, int start, int end) {
        if (array.length <= 1 || end <= start) return 1;
        int counter = 0;
        for (int i = start; i < end; i++) {
            if (array[i] == 'a') counter++;
        }
        int mid = start + ((end - start) / 2);
        return counter + f4(array, start, mid) + f4(array, mid + 1, end);
    }

    /** Note that the 'array' remains constant (unchanged) throughout
     * The code execution! Thus even though f1 is called, the runtime is not N since
     * the input array is constant.
     *
     * The input value N here affects the number of times the while loop is executed.
     * N is halved for every loop, and it is not branching (unlike the previous problems). Thus
     * the runtime is logarithmic.
     *
     */
    public static Asymptotic f5_notation = Asymptotic.BIG_THETA;
    public static Runtime f5_runtime = Runtime.LOG_N;
    public void f5(int n) {
        int[] array = {1, 2, 3};
        while (n > 0) {
            f1(array);
            n = n / 2;
        }
    }

    /** The worst case situation is that if code execution has to go through all the elements
     * of the array. However, there's always possibility that better cases can happen
     * depending on the input array. Thus, the runtime is UPPER BOUNDED O(N).
     */
    public static Asymptotic f6_notation = Asymptotic.BIG_O;
    public static Runtime f6_runtime = Runtime.LINEAR;
    public void f6(int[] array) {
        for (int i = 1; i < array.length; i++) {
            if (array[i] == array[i-1]) {
                System.out.println("Sarah is the potatoest");
                return;
            }
        }
    }

    /** Explanation: In the worst case scenario, the code execution will always
     * execute the 'else' suite, branching to 3 different branches. We can tell that it is
     * upper bounded by a exponential runtime.
     *
     * In the best case scenario (input array is sorted), the execution process still have
     * to go through most of the array (notice we're not halving at all). Thus,
     * the runtime is lower bounded linearly.
     */
    public static Asymptotic f7_notation = Asymptotic.BIG_O;
    public static Runtime f7_runtime = Runtime.EXPONENTIAL;
    public static Asymptotic f7_omega_notation = Asymptotic.BIG_OMEGA;
    public static Runtime f7_omega_runtime = Runtime.LINEAR;
    /* When f7 is first called, start will be 0 and end will be the length of the array - 1 */
    public int f7(int[] array, int start, int end) {
        if (array.length <= 1 || end <= start) {
            return 1;
        } else if (array[start] <= array[end]) {
            return f7(array, start + 1, end - 1);
        } else {
            int tmp = array[start];
            array[start] = array[end];
            array[end] = tmp;
            return f7(array, start + 1, end) + f7(array, start, end - 1)
                    + f7(array, start + 1, end - 1);
        }
    }
}
