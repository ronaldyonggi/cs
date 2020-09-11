package bearmaps;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.NoSuchElementException;

public class ArrayHeapMinPQ<T> implements ExtrinsicMinPQ<T> {

    /** Use an array data structure. Generic array creation is not allowed in Java, hence
     * the implementation uses a workaround. Explanation provided in ArrayHeapMinPQ
     * constructor.
     *
     */
    private Node[] items;

    /** Keeps track of how many elements present in the array.
     *
     */
    private int size;

    /** We can use a HashMap containing...
     * 1. Key: the item of each node
     * 2. Value: integer representing how many occurrences of each item is found.
     *
     * With a HashMap, we can determine whether a Key is contained using the
     * containsKey method. According to the official Oracle API docs, assuming the hash function
     * disperse the items properly among buckets, contains runtime is constant.
     */
    private HashMap<T, Double> maps;

    private class Node {
        private T item;
        private double priority;

        Node(T e, double p){
            item = e;
            priority = p;
        }

        T getItem() {
            return item;
        }

        double getPriority(){
            return priority;
        }

        void setPriority(double p){
            priority = p;
        }
    }

    /** ArrayHeapMinPQ Constructor.
     * Typically Java doesn't allow generic array creation.
     * The project FAQ hints that an easy fix is to use new ArrayHeapMinPQ.Node[size].
     * This will give an "unchecked" warning, which can be suppressed
     * with @SuppressWarnings.
     *
     */
    @SuppressWarnings("unchecked")
    public ArrayHeapMinPQ() {
        items = new ArrayHeapMinPQ.Node[10];
        maps = new HashMap<T, Double>();
    }

    @Override
    public void add (T item, double priority) {
        if (contains(item)) throw new IllegalArgumentException();
        /** If the array is full, double the size of the array.
         *
         */
        if (size() == items.length) resize(size() * 2);
        /** Simply add an item by setting the array of [size]
         * to be the new node.
         *
         */
        items[size()] = new Node(item, priority);
        /** Add the item to the maps.
         *
         */
        maps.put(item, priority);
        size++;
        /** Adjust the index of the node that was just inserted in case
         * the position is incorrect.
         *
         */
        fixIndex(size()-1);
    }

    @Override
    public boolean contains(T item){
        return maps.containsKey(item);
    }

    @Override
    public T getSmallest(){
        if (items[0] == null) throw new NoSuchElementException();
        /** The node with the smallest priority is simply
         * the first element in the array.
         *
         */
        return items[0].getItem();
    }

    @Override
    public T removeSmallest(){
        if (items[0] == null) throw new NoSuchElementException();
        T toBeReturned = getSmallest();
        maps.remove(toBeReturned);
        /** Swap the last element with the first element of the array, then null
         * that last element.
         *
         */
        swap(0, size()-1);
        items[size() - 1] = null;
        size--;
        return toBeReturned;
    }

    @Override
    public int size(){
        return size;
    }

    @Override
    public void changePriority(T item, double priority){
        if (!contains(item)) throw new NoSuchElementException();
        int toBeChangedIndex = findIndex(0, item);
        Node toBeChangedNode = getNodeAtIndex(toBeChangedIndex);
        toBeChangedNode.setPriority(priority);
        fixIndex(toBeChangedIndex);
    }

    /** ==== Array Representation of the Heap ====
     *
     * Items indexing starts from 0.
     *
     * Methods below are adapted from Heaps and PQs Lab CS61B Fall 2018.
     */

    private int getLeftChild(int index){
        return (index * 2) + 1;
    }

    private int getRightChild(int index){
        return (index * 2) + 2;
    }

    private int getParent(int index){
        return (index - 1) / 2;
    }

    private void resize(int capacity){
        /** The Arrays.copyOf is a convenient method that returns a
         * new array that has the same elements as the input array, but with
         * a new length.
         *
         */
        Node[] newItems = Arrays.copyOf(items, capacity);
        items = newItems;
    }

    private Node getNodeAtIndex(int index){
        return items[index];
    }

    private void swap(int index1, int index2){
        Node temp = items[index1];
        items[index1] = items[index2];
        items[index2] = temp;
    }

    /** Helper method that returns the index of the Node that contains
     * the input item. If the node isn't found, return -1.
     */
    private int findIndex(int index, T item){
        Node currentNode = getNodeAtIndex(index);
        /** If we've reached a null node, that means the node isn't found.
         * Return -1.
         */
        if (currentNode == null) return -1;

        /** If the item is found, return the index.
         *
         */
        else if (currentNode.getItem().equals(item)) return index;
        /** Otherwise, recursive call findIndex on both left child
         * and right child and return whichever's final result is not -1. If
         * both are -1, then it will return -1.
         */
        else {
            int leftSide = findIndex(getLeftChild(index), item);
            int rightSide = findIndex(getRightChild(index), item);
            if (leftSide == -1) return rightSide;
            else return leftSide;
        }
    }

    /** Checks whether a node is a root. A node is a root
     * if its index is 0.
     *
     */
    private boolean isRoot(int index){
        return index == 0;
    }

    /** Checks whether a node is a Leaf. A node is a leaf if it doesn't have
     * a left child.
     *
     */
    private boolean isLeaf(int index){
        /** In heaps, there can't exist a node with only a single right child.
         * Therefore to check whether a node is a leaf, simply check whether
         * it has a left child.
         */
        int leftChildIndex = getLeftChild(index);
        return getNodeAtIndex(leftChildIndex) == null;
    }

    /** Returns true if a node's parent has greater priority than
     * the node's priority. Otherwise returns false.
     *
     */
    private boolean parentMorePriority(int index){
        double parentPriority = getNodeAtIndex(getParent(index)).getPriority();
        double currentPriority = getNodeAtIndex(index).getPriority();
        /** Returns true if the priority of the parent Node less than the priority
         * of the current node. Returns false otherwise.
         */
        return parentPriority > currentPriority;
    }

    /** Returns true if there exist a child that has less priority than the node's
     * priority. Otherwise returns false.
     */
    private boolean oneChildIsLess(int index){
        double currentPrio = getNodeAtIndex(index).getPriority();
        int lessChildIndex = min(getLeftChild(index), getRightChild(index));
        return getNodeAtIndex(lessChildIndex).getPriority() < currentPrio;
    }

    /** Helper method to check whether whether a node has only one (left) child.
     * Simply check whether a node has a right child.
     */
    private boolean hasOnlyOneChild(int index){
        int rightChildIndex = getRightChild(index);
        Node rightChildNode = getNodeAtIndex(rightChildIndex);
        return rightChildNode == null;
    }

    /** Takes in 2 indeces and return the index where the node's priority is less.
     *
     */
    private int min(int index1, int index2) {
        Node node2 = getNodeAtIndex(index2);
        if (node2 == null) return index1;
        Node node1 = getNodeAtIndex(index1);
        if (node1 == null) return index2;
        double prio1 = node1.getPriority();
        double prio2 = node2.getPriority();

        if (prio1 < prio2) return index1;
        else return index2;
    }

    /** Takes in an index and moves that node up
     *
     */
    private void swimUp(int index) {
        /** Notice that we have the 'getParent' method and 'swap' method
         * at our disposal. Simply use these methods to swap between the
         * node and its parent.
         */
        swap(index, getParent(index));
    }

    /** Takes in an index and moves that node down.
     *
     */
    private void swimDown(int index){
        swap(index, min(getLeftChild(index), getRightChild(index)));
    }

    /** Takes in an index and continuously moves that node up as long as:
     * 1. The node is not a root
     * 2. The node's parent has greater priority
     */
    private void continuousSwimUp(int index){
        while ((!isRoot(index)) && parentMorePriority(index)) {
            swimUp(index);
            index = getParent(index);
        }
    }

    /** Helper method that continuously move down a node as long as:
     * 1. The node is not a leaf
     * 2. There exists a child that has less priority than the node's.
     */
    private void continuousSwimDown(int index) {
        while ((!isLeaf(index)) && oneChildIsLess(index)) {
            int nextPosition = min(getLeftChild(index), getRightChild(index));
            swimDown(index);
            index = nextPosition;
        }
    }

    /** Helper method that fixes a node's index after it's mutated.
     */
    private void fixIndex(int index){
        /** As long as the node is not a root and the parent's priority is greater, move up.
         */
        if ((!isRoot(index)) && parentMorePriority(index)) {
            continuousSwimUp(index);
        }
        /** Otherwise, as long as the node is not a leaf and there exist a child that
         * has less priority than the node's, move down.
         */
        else if ((!isLeaf(index)) && oneChildIsLess(index)){
            continuousSwimDown(index);
        }
        /** Otherwise do nothing.*/
    }
}
