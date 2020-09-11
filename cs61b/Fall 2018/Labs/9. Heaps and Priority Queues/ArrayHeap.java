import java.util.ArrayList;

/** A Generic heap class. Unlike Java's priority queue, this heap doesn't just
  * store Comparable objects. Instead, it can store any type of object
  * (represented by type T) and an associated priority value.
  * @author CS 61BL Staff*/
public class ArrayHeap<T> {

    /* DO NOT CHANGE THESE METHODS. */

    /* An ArrayList that stores the nodes in this binary heap. */
    private ArrayList<Node> contents;

    /* A constructor that initializes an empty ArrayHeap. */
    public ArrayHeap() {
        contents = new ArrayList<>();
        contents.add(null);
    }

    /* Returns the number of elements in the priority queue. */
    public int size() {
        return contents.size() - 1;
    }

    /* Returns the node at index INDEX. */
    private Node getNode(int index) {
        if (index >= contents.size()) {
            return null;
        } else {
            return contents.get(index);
        }
    }

    /* Sets the node at INDEX to N */
    private void setNode(int index, Node n) {
        // In the case that the ArrayList is not big enough
        // add null elements until it is the right size
        while (index + 1 > contents.size()) {
            contents.add(null);
        }
        contents.set(index, n);
    }

    /* Returns and removes the node located at INDEX. */
    private Node removeNode(int index) {
        if (index >= contents.size()) {
            return null;
        } else {
            return contents.remove(index);
        }
    }

    /* Swap the nodes at the two indices. */
    private void swap(int index1, int index2) {
        Node node1 = getNode(index1);
        Node node2 = getNode(index2);
        this.contents.set(index1, node2);
        this.contents.set(index2, node1);
    }

    /* Prints out the heap sideways. Use for debugging. */
    @Override
    public String toString() {
        return toStringHelper(1, "");
    }

    /* Recursive helper method for toString. */
    private String toStringHelper(int index, String soFar) {
        if (getNode(index) == null) {
            return "";
        } else {
            String toReturn = "";
            int rightChild = getRightOf(index);
            toReturn += toStringHelper(rightChild, "        " + soFar);
            if (getNode(rightChild) != null) {
                toReturn += soFar + "    /";
            }
            toReturn += "\n" + soFar + getNode(index) + "\n";
            int leftChild = getLeftOf(index);
            if (getNode(leftChild) != null) {
                toReturn += soFar + "    \\";
            }
            toReturn += toStringHelper(leftChild, "        " + soFar);
            return toReturn;
        }
    }

    /* A Node class that stores items and their associated priorities. */
    public class Node {
        private T item;
        private double priority;

        private Node(T item, double priority) {
            this.item = item;
            this.priority = priority;
        }

        public T item() {
            return this.item;
        }

        public double priority() {
            return this.priority;
        }

        public void setPriority(double priority) {
            this.priority = priority;
        }

        @Override
        public String toString() {
            return this.item.toString() + ", " + this.priority;
        }
    }

    /* FILL IN THE METHODS BELOW. */

    /* Returns the index of the node to the left of the node at i. */
    private int getLeftOf(int i) {
        /**
         * Looking at the ArrayHeap constructor, it adds a null Node in the beginning.
         * Thus, our actual elements starts at index 1 since index 0 is reserved for
         * the null Node.
         *
         * Note that the getNode method also follows this convention. Thus the root element
         * is at index 1.
         */
        return i * 2;
    }

    /* Returns the index of the node to the right of the node at i. */
    private int getRightOf(int i) {
        return (i * 2) + 1;
    }

    /* Returns the index of the node that is the parent of the node at i. */
    private int getParentOf(int i) {
        /** Recall in Java, both odd numbers disregard the reminder when being divided.
         * For example, 5 / 2 = 2.
         *
         */
        return i / 2;
    }

    /* Adds the given node as a left child of the node at the given index. */
    private void setLeft(int index, Node n) {
        //YOUR CODE HERE
        int toBeChanged = getLeftOf(index);
        setNode(toBeChanged, n);
        fixIndex(toBeChanged);
    }

    /* Adds the given node as the right child of the node at the given index. */
    private void setRight(int index, Node n) {
        //YOUR CODE HERE
        int toBeChanged = getRightOf(index);
        setNode(toBeChanged, n);
        fixIndex(toBeChanged);
    }

    /** Returns the index of the node with smaller priority. Precondition: not
     * both nodes are null. */
    private int min(int index1, int index2) {
        //YOUR CODE HERE
        /** Obtain the priorities of both Nodes and compare them. Then return the nodes whose
         * priority is lower.
         *
         * Recall that a null object doesn't have .equals() method!! If we use .equals(),
         * we'll get an NullPointerException error. Use '=='!
         */
        Node node1 = getNode(index1);
        if (node1 == null) return index2;
//        if (node1.equals(null)) return index2;
        Node node2 = getNode(index2);
        if (node2 == null) return index1;
//        if (node2.equals(null)) return index1;
        double prio1 = node1.priority();
        double prio2 = node2.priority();

        if (prio1 > prio2) return index2;
        else return index1;

    }

    /* Returns the Node with the smallest priority value, but does not remove it
     * from the heap. */
    public Node peek() {
        //YOUR CODE HERE
        /**
         * 'minIndex' keeps track of the index of the smallest priority Node. Initially set it to 1,
         * then loop through the rest of the nodes and compare their priority values. In the end,
         * we'll return the Node with the smallest priority.
         */
        int minPrioIndex = 1;
        for (int i = 2; i < size(); i++){
            minPrioIndex = min(minPrioIndex, i);
        }
        return getNode(minPrioIndex);
    }

    /* Bubbles up the node currently at the given index. */
    private void bubbleUp(int index) {
        /** Notice that we have the 'getParentOf' method and 'swap' method
         * at our disposal. Simply use this method to swap between the
         * node and its parent.
         */
        swap(index, getParentOf(index));
    }

    /* Bubbles down the node currently at the given index. */
    private void bubbleDown(int index) {
        /** The max method takes into account in case one of the children is
         * null. Thus we don't need to worry whether the node
         * has one child or two children.
         */
        swap(index, max(getLeftOf(index), getRightOf(index)));

    }

    /* Inserts an item with the given priority value. Same as enqueue, or offer. */
    public void insert(T item, double priority) {
        /** If we insert for the first time (e.g. start with an empty array), then
         * simply call setNode at index size() + 1. Remember it's size() + 1
         * because with the way the ArrayHeap is constructred, the size
         * includes the null Node at the beginning.
         *
         */
        if (size() == 0) setNode(size()+1, new Node(item, priority));
        else {
            /** Otherwise, per insertion rule of Heaps, we add the new Node at
             * index 1 more than the current size (we are adding a node!) and
             * make that Node swim up until it reaches the point where its parent has
             * higher priority.
             */
            setNode(size()+1, new Node(item, priority));
            /** Once we added a node, remember that:
             * 1. The total size of the heap increases
             * 2. The index of the node that we just added is equal to the updated
             * size of the heap.
             *
             * Now fix the position of the node that we just added, if needed.
             *
             */
            fixIndex(size());
        }
    }

    /* Returns the element with the smallest priority value, and removes it from
     * the heap. Same as dequeue, or poll. */
    public T removeMin() {
        /** Find the node with the smallest priority using the helper
         * smallestPrioIndex method. We call this method on index 1 since we
         * start scanning from the root.
         *
         */
        Node elementToBeReturned = removeNode(smallestPrioIndex(1));
        return elementToBeReturned.item();
    }

    /* Changes the node in this heap with the given item to have the given
     * priority. You can assume the heap will not have two nodes with the same
     * item. Check for item equality with .equals(), not == */
    public void changePriority(T item, double priority) {
        int toBeChangedIndex = findIndex(1, item);
        Node toBeChangedNode = getNode(toBeChangedIndex);
        toBeChangedNode.setPriority(priority);
        fixIndex(toBeChangedIndex);

    }

    /** ======= SELF WRITTEN METHODS ========
     *
     */

    /** Helper method that scans through the heap starting from input node and returns the
     * index of the node with the smallest priority.
     */
    private int smallestPrioIndex(int index){
        /** If the Node doesn't have any child, then we've arrived at the right node.
         */
        if (isLeaf(index)) return index;
        /** If the's only one child, continue calling smallestPrioIndex on
         * the node's left child.
         */
        else if (hasOnlyOneChild(index)) return smallestPrioIndex(getLeftOf(index));
        /**
         * Otherwise, there has to be 2 children! Return the smallest of the result of
         * calling smallestPrioIndex on both the left child and right child.
         */
        else return min(smallestPrioIndex(getLeftOf(index)), smallestPrioIndex(getRightOf(index)));
    }

    /** Helper method that returns the index of the Node that contains
     * the input item. If the node isn't found, return -1.
     */
    private int findIndex(int index, T item){
        Node currentNode = getNode(index);
        /** If we've reached a null node, that means the node isn't found.
         * Return -1.
         */
        if (currentNode == null) return -1;

        /** If the item is found, return the index.
         *
         */
        else if (currentNode.item().equals(item)) return index;
        /** Otherwise, recursive call findIndex on both left child
         * and right child and return whichever's final result is not -1. If
         * both are -1, then it will return -1.
         */
        else {
            int leftSide = findIndex(getLeftOf(index), item);
            int rightSide = findIndex(getRightOf(index), item);
            if (leftSide == -1) return rightSide;
            else return leftSide;
        }
    }

    /** Helper method to check whether a node is a root.
     */
    private boolean isRoot(int index){
        return getParentOf(index) == 0;
    }

    /** Helper method to check whether a parent's priority is less than the
     * current node's.
     */
    private boolean parentLessPriority(int index){
        double parentPriority = getNode(getParentOf(index)).priority();
        double currentPriority = getNode(index).priority();
        /** Returns true if the priority of the parent Node less than the priority
         * of the current node. Returns false otherwise.
         */
        return parentPriority < currentPriority;
    }

    /** Helper method to check whether a node is a leaf (has no children).
     * In a heap, it is not allowed to have a node with
     * only a single right child. Either a node...
     * 1. ...has no children (a leaf node)
     * 2. ...has a single left children
     * 3. ...has 2 children, left and right.
     *
     */
    private boolean isLeaf(int index){
        int leftChildIndex = getLeftOf(index);
        Node leftChildNode = getNode(leftChildIndex);
        return leftChildNode == null;
    }

    /** Helper method that returns true if exists a child that has greater
     * priority than the node's priority. Otherwise returns false.
     */
    private boolean oneChildIsGreater(int index){
        double currentPrio = getNode(index).priority();

        /** If the node has only one (left) child, compare the priority of the
         * left child with the current node's.
         */
        if (hasOnlyOneChild(index)){
            double leftChildPrio = getNode(getLeftOf(index)).priority();
            return leftChildPrio > currentPrio;
        }
        /** Otherwise if there are 2 children, get the priority of the
         * greatest of the 2 children and compare it with the current node's.
         */
        else {
            int greaterChildIndex = max(getLeftOf(index), getRightOf(index));
            return getNode(greaterChildIndex).priority() > currentPrio;
        }
    }

    /** Helper method to check whether whether a node has only one (left) child.
     * Simply check whether a node has a right child.
     */
    private boolean hasOnlyOneChild(int index){
        int rightChildIndex = getRightOf(index);
        Node rightChildNode = getNode(rightChildIndex);
        return rightChildNode == null;
    }

    /** Returns the index of the node with greater priority. Precondition: not
     * both nodes are null. */
    private int max(int index1, int index2) {
        /** Obtain the priorities of both Nodes and compare them.
         * Returns the index of the node whose priority is greater.
         *
         * If one of the node is null, then simply return the other node.
         *
         * Similar to min method, null object doesn't have .equals() method!
         * Use '==' instead!
         */
        Node node1 = getNode(index1);
        if (node1 == null) return index2;
//        if (node1.equals(null)) return index2;
        Node node2 = getNode(index2);
        if (node2 == null) return index1;
//        if (node2.equals(null)) return index1;
        double prio1 = node1.priority();
        double prio2 = node2.priority();

        if (prio1 > prio2) return index1;
        else return index2;

    }

    /** Helper method that continuously move up a node as long as:
     * 1. It is not a root
     * 2. Its priority is greater than its parent.
     */
    private void continuousBubbleUp(int index){
        while ((!isRoot(index)) && parentLessPriority(index)) {
            bubbleUp(index);
            index = getParentOf(index);
        }
    }

    /** Helper method that continuously move down a node as long as:
     * 1. The node is not a leaf
     * 2. There exists a child that has greater priority than the node's priority.
     */
    private void continuousBubbleDown(int index) {
        while ((!isLeaf(index)) && oneChildIsGreater(index)) {
            int nextPosition = max(getLeftOf(index), getRightOf(index));
            bubbleDown(index);
            index = nextPosition;
        }
    }

    /** Helper method that fixes a node's index after it's mutated. Makes use of
     * the continuousBubbleUp and continuousBubbleDown method.
     */
    private void fixIndex(int index){
        /** As long as the current node is not a root and its priority is greater than its
         * parent, move up.
         */
        if ((!isRoot(index)) && parentLessPriority(index)) {
            continuousBubbleUp(index);
        }
        /** Otherwise, as long as the current node is not a leaf and its
         * child / children's priority is greater than the priority of the current node, move
         * down.
         */
        else if ((!isLeaf(index)) && oneChildIsGreater(index)){
            continuousBubbleDown(index);
        }
        /** Otherwise do nothing.*/
    }
}
