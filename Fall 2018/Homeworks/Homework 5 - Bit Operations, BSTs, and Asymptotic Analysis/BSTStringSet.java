import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

/**
 * Implementation of a BST based String Set.
 * @author
 */
public class BSTStringSet implements StringSet {
    /** Creates a new empty set. */
    public BSTStringSet() {
        root = null;
    }

    @Override
    public void put(String s) {
        // FILL WITH SOLUTION
    }

    @Override
    public boolean contains(String s) {
        return false; // REPLACE WITH SOLUTION
    }


    @Override
    public List<String> asList() {
        return null; // REPLACE WITH SOLUTION
    }

    /** Represents a single Node of the tree. */
    private static class Node {
        /** String stored in this Node. */
        private String s;
        /** Left child of this Node. */
        private Node left;
        /** Right child of this Node. */
        private Node right;

        /** Creates a Node containing SP. */
        Node(String sp) {
            s = sp;
        }
    }

    /** Root node of the tree. */
    private Node root;
}
