package es.datastructur.synthesizer;
import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.Objects;

//TODO: Make sure to that this class and all of its methods are public
//TODO: Make sure to add the override tag for all overridden methods
//TODO: Make sure to make this class implement BoundedQueue<T>

public class ArrayRingBuffer<T> implements BoundedQueue<T>  {
    /* Index for the next dequeue or peek. */
    private int first;
    /* Index for the next enqueue. */
    private int last;
    /* Variable for the fillCount. */
    private int fillCount;
    /* Array for storing the buffer data. */
    private T[] rb;

    /**
     * Create a new ArrayRingBuffer with the given capacity.
     */
    public ArrayRingBuffer(int capacity) {
        // TODO: Create new array with capacity elements.
        //       first, last, and fillCount should all be set to 0.
        rb = (T[]) new Object[capacity];
        first = 0;
        last = 0;
        fillCount = 0;
    }

    @Override
    public int capacity(){
        return rb.length;
    }

    @Override
    public int fillCount(){
        return fillCount;
    }


    /**
     * Adds x to the end of the ring buffer. If there is no room, then
     * throw new RuntimeException("Ring buffer overflow").
     */
    @Override
    public void enqueue(T x) {
        // TODO: Enqueue the item. Don't forget to increase fillCount and update
        //       last.
        if (isFull()){
            throw new RuntimeException("Ring buffer overflow");
        } else {
            rb[last] = x;
            last++;
            fillCount++;
            if (last > capacity() - 1){
                last = 0;
            }
        }
    }

    /**
     * Dequeue oldest item in the ring buffer. If the buffer is empty, then
     * throw new RuntimeException("Ring buffer underflow").
     */
    @Override
    public T dequeue() {
        // TODO: Dequeue the first item. Don't forget to decrease fillCount and
        //       update first.
        if (isEmpty()){
            throw new RuntimeException("Ring buffer underflow");
        } else {
            T toBeReturned = rb[first];
            first++;
            fillCount--;
            if (first > capacity() - 1) {
                first = 0;
            }
            return toBeReturned;
        }
    }

    /**
     * Return oldest item, but don't remove it. If the buffer is empty, then
     * throw new RuntimeException("Ring buffer underflow").
     */
    @Override
    public T peek() {
        // TODO: Return the first item. None of your instance variables should
        //       change.
        if (isEmpty()){
            throw new RuntimeException("Ring buffer underflow");
        } else {
            return rb[first];
        }
    }

    // TODO: When you get to part 4, implement the needed code to support
    //       iteration and equals.

    /**
     * Returns an iterator object
     * @return an ArrayRingBuffer iterator
     */
    @Override
    public Iterator<T> iterator() {
        return new ArrayRingBufferIterator();
    }

    /**
     * Private class that implements Iterator interface
     */
    private class ArrayRingBufferIterator implements Iterator<T>{
        private int firstIterator;
        private int fillCountIterator;

        public ArrayRingBufferIterator() {
            firstIterator = first;
            fillCountIterator = fillCount;
        }

        public boolean hasNext() {
            return (fillCountIterator != 0);
        }

        public T next() {
            if (!hasNext()) {
                throw new NoSuchElementException();
            }
            T toBeNext = (T) rb[firstIterator];
            firstIterator++;
            fillCountIterator--;
            if (firstIterator > capacity() - 1) {
                firstIterator = 0;
            }
            return toBeNext;
        }
    }

    @Override
    public boolean equals(Object o) {
        ArrayRingBuffer other = (ArrayRingBuffer) o;
        /**
         * if the fillCount is different, they are not equal
         */
        if (fillCount() != other.fillCount()) {
            return false;
        }
        Iterator thisIter = this.iterator();
        Iterator otherIter = other.iterator();
        while (thisIter.hasNext()) {
            /**
             * Since the array can contain any type of object, convert it to
             * String for comparison purpose
             */
            if (!String.valueOf(thisIter.next()).equals(String.valueOf(otherIter.next()))) {
                return false;
            }
        }
        return true;
    }

}
// TODO: Remove all comments that say TODO when you're done.
