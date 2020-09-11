public class Array {

    public static int[] insert(int[] arr, int item, int position) {
        int[] a = new int[arr.length + 1];
        if (position == 0) {
            System.arraycopy(arr, 0, a, 1, arr.length);
            a[0] = item;
            return a;
        } else if (position > arr.length -1) {
            System.arraycopy(arr, 0, a, 0, arr.length);
            a[a.length - 1] = item;
            return a;
        } else {
            a[position] = item;
            System.arraycopy(arr, 0, a, 0, position);
            System.arraycopy(arr, position, a, position + 1, arr.length - position);
            return a;
        }
    }

    public static void reverse(int[] arr){
        for(int i = 0; i < arr.length/2; i++) {
           int temp = arr[i];
           arr[i] = arr[arr.length - 1 - i];
           arr[arr.length - 1 - i] = temp;
        }
    }

    public static int[] replicate(int[] arr){
        int[] a = new int[sum(arr)];
        int index = 0;
        for (int i: arr){
            for (int j = i; j > 0; j--){
                a[index] = i;
                index ++;
            }
        }
        return a;
    }

    /**
     * Helper public method that sums the elements in an array of integer
     * @param arr the array which elements we want to sum
     * @return the sum of the elements in the array
     */
    public static int sum(int[] arr){
        int sum = 0;
        for (int x:arr){
            sum += x;
        }
        return sum;
    }
}
