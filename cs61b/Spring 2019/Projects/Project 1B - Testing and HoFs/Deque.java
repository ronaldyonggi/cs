/**
 * Deque interface
 * @author Ronald Yonggi
 */
public interface Deque<T> {
    void addFirst (T item);
    void addLast (T item);
    int size();
    T removeFirst();
    T removeLast();
    T get(int index);

    /**
     * Checks if the deque is empty
     * @return True if empty, False otherwise
     */
    default boolean isEmpty() {
        return (size() == 0);
    }

}
