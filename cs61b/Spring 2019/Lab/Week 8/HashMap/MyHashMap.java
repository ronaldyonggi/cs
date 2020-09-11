import java.util.*;

public class MyHashMap<K, V> implements Map61B<K, V> {

    /** ====== HashMap class attributes and instance attributes ======
     *
     */

    /** The 'Entry' class represents a key-value pair.
     *
     */
    private class Entry{
        K key;
        V value;

        /** Entry constructor */
        Entry(K k, V v) {
            key = k;
            value = v;
        }

    }

    private static final int defaultInitialSize = 16;
    private static final double defaultLoadFactor = 0.75;

    /** This HashMap implementation uses LinkedList.
     *
     * Compared to ArrayList
     * Advantage: constant time addition and removal (as long as
     * no resizing occur)
     * Disadvantage: Retrieval takes O(n).
     */
    private List<Entry>[] buckets;

    private int numEntries; // Number of existing key-value pairs in the HashMap
    private double loadFactor;
    private Set<K> keySet;


    /** ======== METHODS OVERRIDDEN FROM Map61B ========
     *
     */

    /** Clear the contents of the HashMap and start new.
     *
     */
    @Override
    public void clear() {
        numEntries = 0;
        initializeLinkedList(buckets.length);
        keySet = new HashSet<>();
    }

    /** Returns true if the HashMap contains the input 'key'. Simply utilize the
     * keySet since they only contain keys and they are unique.
     *
     */
    @Override
    public boolean containsKey(K key){
        return keySet.contains(key);
    }

    @Override
    public V get(K key){
        /** If the key isn't contained in the keySet, returns null
         *
         */
        if (!containsKey(key)) return null;
        else {
            /** Retrieve the index of which bucket the key belongs to.
             *
             */
            int bucketIndex = keyToIndex(key);

            /** LinkedList implements Iterable interface, thus we can loop through
             *  each entry within the linked list via enhanced for loop.
             */
            for (Entry e: buckets[bucketIndex]){
                /** If the key of the entry matches the desired key, return
                 * that entry's value.
                 */
                if (e.key.equals(key)) return e.value;
            }
            return null;
        }
    }

    /** Returns the number of existing key-value pairs in the HashMap.
     *
     */
    @Override
    public int size(){
        return numEntries;
    }

    @Override
    public void put(K key, V value){
        /** If the key already exists in the HashMap, find the entry
         * that has the same key and update its value.
         */
        if (keySet.contains(key)){
            int bucketIndex = keyToIndex(key);
            for (Entry e: buckets[bucketIndex]){
                if (e.key.equals(key)) e.value = value;
            }
        }
        /** Otherwise just add a new entry to the linked list.
         *
         */
        else {
            numEntries++;
            if (((double)numEntries / buckets.length) >= loadFactor) resize(buckets.length * 2);
            int bucketIndex = keyToIndex(key);
            buckets[bucketIndex].add(new Entry(key, value));
            keySet.add(key);
        }

    }

    @Override
    public Set<K> keySet(){
        return keySet;
    }

    @Override
    public V remove(K key){
        /** Implementation is similar to 'get' method.
         *
         */
        if (!containsKey(key)) return null;
        else {
            int bucketIndex = keyToIndex(key);
            for (Entry e: buckets[bucketIndex]){
                if (e.key.equals(key)){
                    /** If the entry with the desired key is found:
                     * 1. Delete the key from the keySet
                     * 2. Delete the entry that contains that key from
                     * the linked list
                     * 3. Decrement numEntries;
                     * 4. Return the value associated with that key.
                     *
                     */
                    V toBeReturned = e.value;
                    keySet.remove(key);
                    buckets[bucketIndex].remove(e);
                    numEntries--;
                    return toBeReturned;
                }
            }
            return null;
        }

    }

    @Override
    public V remove(K key, V value){
        /** Implementation is similar to remove(K key) method.
         *
         */
        if (!containsKey(key)) return null;
        else {
            int bucketIndex = keyToIndex(key);
            for (Entry e: buckets[bucketIndex]){
                if (e.key.equals(key)){
                    /** This time, also check if the value contained by the associated
                     * entry is equal to the desired 'value'.
                     */
                    if (e.value.equals(value)){
                        /** If the entry's value is the same as the desired 'value',
                         * 1. Delete the key from the keySet
                         * 2. Delete the entry that contains that key from
                         * the linked list
                         * 3. Decrement numEntries;
                         * 4. Return the value associated with that key.
                         *
                         */
                        V toBeReturned = e.value;
                        keySet.remove(key);
                        buckets[bucketIndex].remove(e);
                        numEntries--;
                        return toBeReturned;
                    }
                    else return null;
                }
            }
            return null;
        }
    }

    @Override
    public Iterator<K> iterator(){
        return keySet.iterator();
    }

    /** ====== CONSTRUCTORS ======
     *
     */

    /** Invokes the 1-argument MyHashMap constructor with parameter
     * (defaultInitialSize).
     */
    public MyHashMap(){
        this(defaultInitialSize);
    }

    /** Invokes the 2-argument MyHashMap constructor with parameters
     * (initialSize, defaultLoadFactor).
     */
    public MyHashMap(int initialSize){
        this(initialSize, defaultLoadFactor);
    }

    /** MyHashMap 2-argument constructor */
    public MyHashMap(int initialSize, double lF){
        loadFactor = lF;
        /** Initialize the linked lists
         *
         */
        initializeLinkedList(initialSize);

        /** Initializes a new HashSet */
        keySet = new HashSet<>();

        numEntries = 0;
    }

    /** ========= PRIVATE METHODS ============
     *
     */

    /** Private method that initializes the linked lists in 'buckets'.
     * Invoke this method within the MyHashMap constructors.
     */
    private void initializeLinkedList(int capacity){
        buckets = new List[capacity];
        for(int i = 0; i < capacity; i++) buckets[i] = new LinkedList<>();
    }

    /** Private method that converts a key to the index of
     * the bucket it belongs to.
     */
    private int keyToIndex(K key){
        /** The difference between floorMod and % is as the following:
         *
         * ==== floorMod ====
         * floorMod(-4, 3) == 2
         * floorMod(4, -3) == -2
         *
         * ==== % ====
         * -4 % 3 == -1
         * 4 % -3 == 1
         *
         * Looking at the difference above, floorMod is more useful since
         * we want to make sure the result of the calculation is a positive
         * number as it represents the index of the bucket we want to assign
         * the key into.
         */
        return Math.floorMod(key.hashCode(), buckets.length);
    }

    /** Private method that resizes the current hashMap to a new
     * hashMap with a new capacity.
     *
     */
    private void resize(int newCapacity){
        /** Save the old hashMap to 'old'.
         *
          */
        List<Entry>[] old = buckets;
        /** Reset the hashMap by re-initialize the linked list with
         * the new capacity.
         *
         */
        initializeLinkedList(newCapacity);

        /** Iterate through the old hashMap (through each linked list within each bucket,
         * then through each entry within each linked list), then use the 'put' method to
         * put each entry into the newly resized bucket.
         *
         */
        for(int i = 0; i < old.length; i++){
            for (Entry e: old[i]) put(e.key, e.value);
        }
    }
}
