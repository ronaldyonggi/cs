/**
 * Array Deque Implementation
 * @author Ronald Yonggi
 */
public class ArrayDeque<T> implements Deque<T> {
    /**
     * Private instance variables
     */
    private T[] items;
    private int size;
    private int nextFirst; // A pointer indicating which index to add item for addFirst()
    private int nextLast; // A pointer indicating which index to add item for addLast()

    /**
     * ArrayDeque Empty Constructor
     */
    public ArrayDeque() {
        items = (T[]) new Object[8];
        size = 0;
        nextFirst = items.length - 1; // Initially set nextFirst to be the end of the list
        nextLast = size; // Initially set nextLast to be the beginning of the list (index 0)
    }

    /**
     * Creates a deep copy of an ArrayDeque
     * @param other the ArrayDeque whose contents to be copied from
     */
    public ArrayDeque(ArrayDeque other) {
        items = (T[]) new Object[other.size]; // Create an array with the same size as 'other'
        System.arraycopy(other, 0, items, 0, other.size); // Copy the contents of 'other' to 'items'
        // Copy the contents of the instance variables as well
        size = other.size;
        nextFirst = other.nextFirst;
        nextLast = other.nextLast;
    }

    /**
     * Resize the list
     * @param capacity the size of the new list
     */
    private void resize (int capacity) {
        T[] a = (T[]) new Object[capacity]; // Create a new array called a with a size of capacity
        System.arraycopy(items, 0, a, 0, size); // Copy the contents of items to a
        items = a; // Change the pointer of items to the array a is pointing at
    }

    /**
     * Inserts an item into the beginning of the list
     * @param item the item to be inserted into the list
     */
    @Override
    public void addFirst (T item) {
       if (size == items.length) {
           resize(size * 2); // If the array is full, double the size of the array
       }
        items[nextFirst] = item; // Assign the slot at index 'nextFirst' to be 'item'
        size += 1; // Increment the size
        if (nextFirst == 0) {
            nextFirst = items.length - 1; // If nextFirst is 0, then set it to the end of the list
        } else {
            nextFirst -= 1; // Otherwise decrement nextFirst since nextFirst is traversing the index backwards
        }
    }

    /**
     * Inserts an item x forward in increasing index
     * @param item the item to be inserted into the list
     */
    @Override
    public void addLast (T item) {
        if (size == items.length) {
            resize(size * 2); // If the list is full, double the size by 2
        }
        items[nextLast] = item; // Assign the slot at index 'nextLast' to be 'item'
        size += 1; // Increment size
        if (nextLast == items.length-1) {
            nextLast = 0; // If nextLast is set at the last index of the list, cycle around to 0
        } else {
            nextLast += 1; // Otherwise just increment nextLast
        }
    }

    /**
     * Returns the item at the given index in the list
     * @return the item at the given index
     */
    @Override
    public T get(int index){
        return items[index];
    }

    /**
     * Returns the number of items in the list
     * @return the number of items in the list
     */
    @Override
    public int size() {
        return size;
    }

    /**
     * Returns the first item and remove it from the list
     * @return
     */
    @Override
    public T removeFirst() {
        if (isEmpty()) {
            return null; // If the list is empty, return null
        }
        if (nextFirst == items.length - 1) {
            nextFirst = 0; // If nextFirst is already at the end of the list, cycle nextFirst to 0
        } else {
            nextFirst += 1; // Otherwise, increment nextFirst by 1
        }
        T x = items[nextFirst]; // Assign x to be the item at index nextFirst
        items[nextFirst] = null; // Null out the item at index nextFirst
        size -= 1; // Decrement the size
        /**
         * If the length of the list is at least 16 or greater and the usage factor is less than 25%, reduce the length of the list by half
         */
        if (items.length >= 16 && size < items.length * 0.25) {
            resize(items.length / 2);
        }
        return x;
    }

    /**
     * Returns the last item and remove it from the list
     * @return the last item in the list
     */
    @Override
    public T removeLast() {
        if (isEmpty()) {
            return null; // If the list is empty, return null
        }
        if (nextLast == 0) {
            nextFirst = items.length - 1; // If nextLast is already at the beginning of the list, cycle back to the end of the list
        } else {
            nextLast -= 1; // Otherwise just decrement nextLast by 1
        }
        T x = items[nextLast]; // Assign x to be the item at index nextLast
        items[nextLast] = null; // Null out the item at index nextLast
        size -= 1; // Decrement the size
        /**
         * If the length of the list is at least 16 or greater and the usage factor is less than 25%, reduce the length of the list by half
         */
        if (items.length >= 16 && size < items.length * 0.25) {
            resize(items.length / 2);
        }
        return x;
    }

}
