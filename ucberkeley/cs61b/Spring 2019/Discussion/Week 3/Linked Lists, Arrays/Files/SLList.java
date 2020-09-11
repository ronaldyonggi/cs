public class SLList {
    private class IntNode {
        public int item;
        public IntNode next;
        public IntNode(int item, IntNode next) {
            this.item = item;
            this.next = next;
        }
    }

    private IntNode first;

    /**
     * SLList constructor, not written in the discussion file but required
     * for instantiating SLList
     * @param x an integer to be inserted as the first element of the SLList
     */
    public SLList(int x) {
        first = new IntNode(x, null);
    }

    public void addFirst(int x) {
        first = new IntNode(x, first);
    }

    /**
     * Return an item x elements from the beginning. Not available
     * in discussion file
     * @param x the index of the desired item
     * @return the desired item that's located at index x
     */
    public int getItem(int x) {
        IntNode pointer = first;
        for (int i = 0; i < x; i++) {
            pointer = pointer.next;
        }
        return pointer.item;
    }

    public void insert(int item, int position) {
        /**
         * If position is 0, then we're adding item to the front
         * of the list
         */
        if (position == 0) {
            addFirst(item);
        }
        IntNode pointer = first;
        /**
         * Start with iterating from 1 because if position is 1,
         * we simply want to update first.next
         */
        for (int i = 1; i < position; i++){
            /**
             * If position is more than the length of the list,
             * add item at the end of the list.
              */
            if (pointer.next == null) {
                pointer.next = new IntNode(item, null);
            }
            pointer = pointer.next;
        }
        pointer.next = new IntNode(item, pointer);
    }

    public void reverse() {
        if (first == null || first.next == null){
            return;
        }

        IntNode pointer = first.next;
        first.next = null;
        while (pointer != null) {
            IntNode next = pointer.next;
            pointer.next = first;
            first = pointer;
            pointer = next;
        }
    }

    public void reverseRecur() {
        first = reverseHelper(first);
    }

    private IntNode reverseHelper(IntNode pointer){
        IntNode reversedPointer = reverseHelper(pointer.next);
        pointer.next.next = pointer;
        pointer.next = null;
        return reversedPointer;
    }
}