import java.security.Key;
import java.util.Iterator;
import java.util.Set;

/** Make K extends Comparable since we want to be able to compare input keys with existing nodes' keys */
public class BSTMap<K extends Comparable<K>, V> implements Map61B<K, V> {
    int size = 0;

    /** Private class Node, contains a constructor */
    private class Node {
        private K key;
        private V value;
        private Node left, right;

        /** Node constructor */
        public Node(K k, V v) {
            key = k;
            value = v;
        }

    }

    /** Root node of a BST. If the BST is empty, set 'root' to null */
    private Node root;

    @Override
    public void clear() {
        /** The clear method simply reset size to 0 and set root to null */
        size = 0;
        root = null;
    }

    /** Checks whether there exists a Node that contains the input 'key' */
    @Override
    public boolean containsKey(K key){
        /** Call getHelper. If the result is null, then such node doesn't exists.
         * Otherwise, such node exists.
         */
        return (!(getHelper(root, key) == null));
    }

    /**
     * A recursive get helper method. Returns the value contained by the Node that has the
     * same 'key' as the input 'key'. If no such Node exists, returns null.
     */
    private V getHelper(Node n, K key){
        /** If we've reached a null node, that means the desired node isn't contained
         * in the tree. Return null.
         */
        if (n == null) return null;

        int compareResult = key.compareTo(n.key);

        /** If the input 'key' is less than the currently selected node's 'key', go to the node's
         * left node and call recursive getHelper.
         */
        if (compareResult < 0) return getHelper(n.left, key);
        /** Same thing goes for the right node */
        else if (compareResult > 0) return getHelper(n.right, key);
        /** If the currently selected node has a 'key' that's the same as the input 'key',
         * return that node's value.
         */
        else return n.value;
    }

    @Override
    public V get(K key){
        /** Use the getHelper method */
        return getHelper(root, key);
    }

    /** Simply returns the size */
    @Override
    public int size(){
        return size;
    }

    @Override
    public void put(K key, V value){
        root = putHelper(root, key, value);
    }

    private Node putHelper(Node n, K key, V value){
        /** If the currently selected node is null, contruct a new Node that has
         * the input 'key' and 'value', and assign it to whoever
         * (e.g. root or n.left or n.right).
         */
        if (n == null){
            size++;
            return new Node(key, value);
        }

        int compareResult = key.compareTo(n.key);

        /** If the input 'key' is less than the current selected node's key, set the left node
         * to be the result of calling recursive putHelper on left side.
         */
        if (compareResult < 0) n.left = putHelper(n.left, key, value);
        /** Same goes for the right side */
        else if (compareResult > 0) n.right = putHelper(n.right, key, value);
        /** Otherwise, if the input key is the same as the current selected node's key,
         * update that node's key.
         */
        else n.value = value;
        /** In the end, if we're updating an existing node's value, we still need to return something since
         * are 'assigning' something in the recursive call (e.g. n.left = putHelper(n.left, key, value).
         * Simply return that node after updating its value.
         */
        return n;
    }

    @Override
    public Set<K> keySet() {
        throw new UnsupportedOperationException();
    }

    @Override
    public V remove(K key){
        throw new UnsupportedOperationException();
    }

    @Override
    public V remove(K key, V value){
        throw new UnsupportedOperationException();
    }

    @Override
    public Iterator<K> iterator() {
        throw new UnsupportedOperationException();
    }

    public void printInOrder(){
        /** Use the printHelper helper method on the root Node */
        printHelper(root);
    }

    private void printHelper(Node n){
        /** If the current selected node is null, do nothing.*/
        if (n == null);
        else {
            /** Call recursive printHelper on left node, then
             * print the current Node's key, then call recursive printHelper
             * on right node.
             */
            printHelper(n.left);
            System.out.println(n.key);
            printHelper(n.right);
        }
    }


}
