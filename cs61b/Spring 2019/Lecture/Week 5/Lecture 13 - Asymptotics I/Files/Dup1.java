import java.util.ArrayList;
import java.util.List;

public class Dup1 {

    public static boolean dup1(int[] A) {
        for (int i = 0; i < A.length; i += 1) {
            for (int j = i + 1; j < A.length; j += 1) {
                if (A[i] == A[j]) {
                    return true;
                }
            }
        }
        return false;
    }

    public static int[] makeArray(int N) {
        int[] A = new int[N];
        for (int i = 0; i < N; i ++) {
            A[i] = i;
        }
        return A;
    }

    public static void main(String[] args) {
        int N = Integer.parseInt(args[0]);
        int[] A = makeArray(N);
        dup1(A);
    }
}