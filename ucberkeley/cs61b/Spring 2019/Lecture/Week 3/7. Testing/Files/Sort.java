public class Sort {
    /** Sorts strings destructively */
    public static void sort(String[] x){
        sort(x, 0); // Call the helper sort method
    }

    private static void sort(String[] x, int start) {
        if (start == x.length) {
            return;
        }
        int smallestIndex = findSmallest(x, start); // Find the smallest index during
        swap(x, start, smallestIndex); // Swap the item at index[start] with the item at index [smallestIndex]
        sort(x, start + 1); // Recursive call sort for the next starting point
    }


    /**
     * Returns the smallest String in x
     * @param x a collection of Strings
     * @return the smallest String in x
     */
    public static int findSmallest(String[] x, int start) {
        int smallestIndex = start;
        for (int i = start; i < x.length; i+= 1) {
            int comparison = x[i].compareTo(x[smallestIndex]); // if x[i] is less than x[smallestIndex], it will return a negative number
            if (comparison < 0) {
                smallestIndex = i;
            }
        }
        return smallestIndex;
    }

    /**
     * Swap item at index [a] with item at index [b]
     * @param x a collection of strings
     * @param a the index of the item to be swapped with item at index [b]
     * @param b the index of the item to be swapped with item at index [a]
     */
    public static void swap(String[] x, int a, int b) {
        String temp = x[a];
        x[a] = x[b];
        x[b] = temp;
    }
}