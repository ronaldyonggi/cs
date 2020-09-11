import java.util.Arrays;

public class Homework0{
    /** B. Max */
    public int forMax(int[] array){
        /** Base case: If the array only contains one element, return that element */
        if (array.length == 1) return array[0];
        int currentMaxIndex = 0;
        for(int i = 1; i < array.length; i++){
            if (array[i] > array[currentMaxIndex]) currentMaxIndex = i;
        }
        return array[currentMaxIndex];
    }

    /** C. 3SUM */
    public boolean threeSum(int[] array){
        /** Sort the array first */
        Arrays.sort(array);
        /**
         * Have 2 additional pointers j and k. j starts at the same position as
         * i, while k starts from the last element of the array.
         */
        for (int i = 0; i < array.length-1; i++){
            int j = i;
            int k = array.length - 1;
            while (j <= k){
                int sum = array[i] + array[j] + array[k];
                if (sum == 0) return true;
                else if (sum < 0) j++;
                else if (sum > 0) k--;
            }
        }
        return false;
    }

    /** D. 3SUM_DISTINCT */
    public boolean threeSumDistinct(int[] array){
        /** Sort the array first */
        Arrays.sort(array);
        /**
         * Similar to 3SUM, but j can't be the same as i. Make j starts at 1 element after i
         */
        for (int i = 0; i < array.length-1; i++){
            int j = i+1;
            int k = array.length - 1;
            /**
             * None of the pointers can overlap. Thus the while loop this time runs
             * as long as j < k.
             */
            while (j < k){
                int sum = array[i] + array[j] + array[k];
                if (sum == 0) return true;
                else if (sum < 0) j++;
                else if (sum > 0) k--;
            }
        }
        return false;
    }
}