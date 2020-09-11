/**
 * Double Ended Deque (Circular Sentinel)
 * @author Ronald Yonggi
 */

public class LinkedListDeque<T> implements Deque<T> {
    /**
     * Node private class
     */
   private class Node{
        /**
         * A pointer that points to the previous node
         */
       public Node prev;
        /**
         * The item contained in a node
         */
       public T item;
        /**
         * A pointer that points to the next node
         */
       public Node next;

        /**
         * Returns an individual circular node.
         * @param p a pointer to the previous node
         * @param i the item contained in a node
         * @param n a pointer to the next node
         */
        public Node(Node p, T i, Node n){
            prev = p;
            item = i;
            next = n;
        }
   }

    /**
     * The sentinel node, which exists in every deque but is not included as part of the elements in a deque.
     */
   private Node sentinel;
    /**
     * The size of a deque
     */
   private int size;

    /**
     * Empty deque constructor
     */
    public LinkedListDeque(){
        /**
         * A sentinel node. It contains the null item since the null item works for most data types.
         * The previous and the next pointer should point back at the sentinel.
         */
        sentinel = new Node(null, null, null);
        sentinel.next = sentinel; // Initiate the .prev and .next AFTER we finished initiating the sentinel
        sentinel.prev = sentinel;
        size = 0;
    }

    /**
     * Creates a deep copy of a deque. The original deque is a separate object from the copy.
     * @param other a deque whose contains is to be copied.
     */
    public LinkedListDeque(LinkedListDeque other) {
        sentinel = new Node(null, null, null);
        sentinel.next = sentinel; // Initiate the .prev and .next AFTER we finished initiating the sentinel
        sentinel.prev = sentinel;
        size = 0;
        for (int i = 0; i < other.size; i++){
            addLast((T) other.get(i)); // Use casting!
        }
    }

    /**
     * Adds an item to the front (sentinel.next) of the deque
     * @param item the item to be added to the deque
     */
    @Override
    public void addFirst(T item){
        Node a = new Node(sentinel, item, sentinel.next);
        sentinel.next.prev = a;
        sentinel.next = a;
        size++;
    }

    /**
     * Adds an item to the back (sentinel.prev) of the deque
     * @param item the item to be added to the back of the deque
     */
    @Override
    public void addLast(T item){
        Node a = new Node(sentinel.prev, item, sentinel);
        sentinel.prev.next = a;
        sentinel.prev = a;
        size++;
    }

    /**
     * Returns the size of a deque (the number of nodes that's non-sentinel)
     * @return the size of a deque
     */
    @Override
    public int size(){
        return size;
    }

    /**
     * Prints all the items in the deque from first to last, separated by a space.
     * Once all items have been printed, print out a new line.
     */
    public void printDeque(){
        Node pointer = sentinel.next; // Set the pointer to sentinel.next
        while (pointer.item != null) { // As long as the item of the current Node is not null
            System.out.print(pointer.item.toString()); // Convert the item to String then print it
            System.out.print(" "); // Prints a space
            pointer = pointer.next; // Cycle forward to the next Node
        }
        System.out.println(""); // Once done with the loop, print a new line
    }

    /**
     * Returns the item contained by the node in front of the sentinel, then remove that node.
     * @return the item contained by the node after the sentinel. If there's no node other than the sentinel, returns null
     */
    @Override
    public T removeFirst(){
        if (isEmpty()) return null;
        else {
            T result = sentinel.next.item;
            Node a = new Node(sentinel, sentinel.next.next.item, sentinel.next.next.next);
            sentinel.next.prev = a;
            sentinel.next = a;
            size --;
            return result;
        }
    }

    /**
     * Returns the item contained by the node behind the sentinel, then remove that node.
     * @return the item contained by the node behind the sentinel. If there's no node other than the sentinel, returns null
     */
    @Override
    public T removeLast(){
        if (isEmpty()) return null;
        else {
            T result = sentinel.prev.item;
            Node a = new Node(sentinel.prev.prev.prev, sentinel.prev.prev.item, sentinel);
            sentinel.prev.next = a;
            sentinel.prev= a;
            size --;
            return result;
        }
    }

    /**
     * Returns the item at the given index of a deque
     * @param index the index of the desired item
     * @return an item of the given index in a deque
     */
    @Override
    public T get(int index){
        Node pointer = sentinel;
        if (index >= size / 2) { // If the index is equal to or greater than half of the size, iterate backwards
            for (int i = size - index; i > 0; i--) pointer = pointer.prev;
            return pointer.item;
        } else { // Otherwise if the index is less than half of the size, iterate forward
            for (int i = size - index; i > 0; i--) pointer = pointer.next;
            return pointer.item;
        }
    }

    /**
     * Helper method that cycles through the list in forward direction.
     * @param index the index of the desired item in the list
     * @param pointer the current Node that the method is highlighting at
     */
    private T helperForward(int index, Node pointer) {
        if (index == 0) return pointer.item;
        else return helperForward(index, pointer.next);
    }

    /**
     * Helper method that cycles through the list in backwards direction.
     * @param indexReversed the index of the desired item in the list
     * @param pointer the current Node that the method is highlighting at
     */
    private T helperBackwards(int indexReversed, Node pointer){
        if (indexReversed == 0) return pointer.item;
        else return helperBackwards(indexReversed - 1, pointer.prev);
    }

    /**
     * The recursive version of the get method
     * @param index the index of the desired item
     * @return an item of the given index in a deque
     */
    public T getRecursive(int index){
        // Similar to regular 'get', if the desired index is greater or equal to half of the size of the list,
        // then cycle backwards.
        if (index >= size / 2) return helperBackwards(size - index, sentinel);
        else return helperForward(index, sentinel);
    }

}
