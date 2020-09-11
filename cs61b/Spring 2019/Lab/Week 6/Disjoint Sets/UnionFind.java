import java.util.NoSuchElementException;

public class UnionFind {

    // TODO - Add instance variables?
    private int[] parents;

    /* Creates a UnionFind data structure holding n vertices. Initially, all
       vertices are in disjoint sets. */
    public UnionFind(int n) {
        // TODO
        /**
         * Create an array of size n and initiate all the elements by -1 since
         * initially, all numbers are individual roots.
         */
        parents = new int[n];
        for (int i = 0; i < n; i++) {
            parents[i] = -1;
        }
    }

    /* Throws an exception if v1 is not a valid index. */
    private void validate(int vertex) {
        // TODO
        if (vertex < 0 || vertex > parents.length - 1){
            throw new IllegalArgumentException();
        }
    }

    /* Returns the size of the set v1 belongs to. */
    public int sizeOf(int v1) {
        // TODO
        validate(v1);
        return -parents[find(v1)];
    }

    /* Returns the parent of v1. If v1 is the root of a tree, returns the
       negative size of the tree for which v1 is the root. */
    public int parent(int v1) {
        // TODO
        validate(v1);
        return parents[v1];
    }

    /* Returns true if nodes v1 and v2 are connected. */
    public boolean connected(int v1, int v2) {
        // TODO
        validate(v1);
        validate(v2);
        return find(v1) == find(v2);
    }

    /* Connects two elements v1 and v2 together. v1 and v2 can be any valid 
       elements, and a union-by-size heuristic is used. If the sizes of the sets
       are equal, tie break by connecting v1's root to v2's root. Unioning a 
       vertex with itself or vertices that are already connected should not 
       change the sets but may alter the internal structure of the data. */
    public void union(int v1, int v2) {
        // TODO
        validate(v1);
        validate(v2);
        if (!connected(v1, v2)) {
            if (sizeOf(v1)> sizeOf(v2)) {
                parents[v2] = find(v1);
                parents[find(v1)] --;
            } else {
                parents[v1] = find(v2);
                parents[find(v2)] --;
            }
        }
    }

    /* Returns the root of the set V belongs to. Path-compression is employed
       allowing for fast search-time. */
    public int find(int vertex) {
        // TODO
        /**
         * The idea is to keep looking at the parent of the index until we find an index
         * whose parent is negative. That means that index is the root.
         */
        validate(vertex);
        int root = vertex;
        while (parent(root) > -1) {
            root = parent(root);
        }

        /**
         * Apply path-compression by assigning root to the parent of the indeces that
         * we went through in the first place to find the root
         */
        int temp;
        while (vertex != root) {
            temp = parent(vertex);
            parents[vertex] = root;
            vertex = temp;
        }
        return root;
    }

}
