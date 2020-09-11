/**
 * Percolation data type
 * @author Ronald Yonggi
 */

package hw2;

import edu.princeton.cs.algs4.WeightedQuickUnionUF;

/**
 * The percolation system is actually made of a 1D int array from WeightedQuickUnionUF
 */
public class Percolation extends WeightedQuickUnionUF {

    /**
     * An array that indicates whether a site is open. true = open.
     */
    private boolean[] isOpenArray;

    /**
     * Declare a second WQUF. This WQUF doesn't connect all
     * the virtual bottom sites.
     *
     * The point is to use the main WQUF for checking if the system
     * percolates, and use WQUF2 to check if the site is full.
     */
    private WeightedQuickUnionUF wquf2;

    /**
     * The length of the sites system if it is depicted as an NxN grid.
     */
    private int length;

    /**
     * Represents the number of open sites. Initially no sites are open.
     */
    private int openSites = 0;

    /**
     * Create an N-by-N grid by initializing the WeightedQuickUnionUF array
     * and the open[] array;
     * @param N the dimension of the grid
     */
    public Percolation(int N) {
        /**
         * Calls the WeightedQuickUnionUF constructor. The WeightedQuickUnionUF class
         * already comes with a validator that checks input N and throw
         * IllegalArgumentException if N is invalid.
         */
        super(N*N);

        /** Declare a second WQUF.
         *
         */
        wquf2 = new WeightedQuickUnionUF(N*N);


        isOpenArray = new boolean[N*N];
        length = N;

        /**
         * Connect all the top sites for both main WQUF
         * and the second WQUF
         */
        for(int i = 1; i < length; i++) {
            union(0, i);
            wquf2.union(0, i);
        }

        /**
         * Connect all the bottom sites of just the main WQUF
         */
        for (int i = N*N - 2; i >= N*N - N; i--) {
            union(N*N - 1, i);
        }
    }

    /**
     * Throws an IndexOutofBoundsException if either the input row
     * or column is greater than length - 1
     * @param r input row
     * @param c input column
     */
    private void validate(int r, int c) {
        if (r > length-1) {
            throw new IndexOutOfBoundsException("Invalid row input");
        } else if (c > length - 1) {
            throw new IndexOutOfBoundsException("Invalid column input");
        }
    }

    /**
     * Converts a 2D input row and column to a 1D index
     * @param row row of interest
     * @param col column of interest
     * @return index of 1D array representation
     */
    private int convert2Dto1D(int row, int col){
        validate(row, col);
        /**
         * Each vertical index (row) counts as 'length' 1D indeces. For example in
         * 5x5 grid, each row represents multiple of 5.
         */
        return (row * length) + col;
    }

    /**
     * Checks if a site is open.
     * @param row the row of the site
     * @param col the column of the site
     * @return true if the site is open, false otherwise
     */
    public boolean isOpen(int row, int col) {
        validate(row, col);
        return isOpenArray[convert2Dto1D(row, col)];
    }

    /**
     * Open the site (row, col) if it's not open already. A site is open if
     * its boolean isOpenArray value is true.
     * @param row the row of the spot
     * @param col the column of the spot
     */
    public void open(int row, int col){
        validate(row, col);

        if (!isOpen(row, col)) {
            int current = convert2Dto1D(row, col);
            isOpenArray[current] = true;
            openSites += 1;

            /**
             * ====== ABOVE =====
             * Checks if the site above the current site is valid (within the
             * NxN grid). If yes and the site is open, connect
             * with current site.
             */
            if(row - 1 >= 0) {
                int above = convert2Dto1D(row-1, col);
                if (isOpen(row-1, col)) {
                    /**
                     * Connect both main wquf and second wquf
                     */
                    union(current, above);
                    wquf2.union(current, above);
                }
            }

            /**
             * ===== BELOW =====
             * Same with ABOVE, but for the site below current site
             */
            if(row + 1 <= length - 1) {
                int below = convert2Dto1D(row+1, col);
                if (isOpen(row+1, col)) {
                    union(current, below);
                    wquf2.union(current, below);
                }
            }

            /**
             * ===== LEFT =====
             */
            if(col - 1 >= 0) {
                int left = convert2Dto1D(row, col - 1);
                if (isOpen(row, col-1)) {
                    union(current, left);
                    wquf2.union(current, left);
                }
            }

            /**
             * ===== RIGHT ======
             */
            if (col + 1 <= length-1) {
                int right = convert2Dto1D(row, col + 1);
                if (isOpen(row, col+1)) {
                    union(current, right);
                    wquf2.union(current,right);
                }
            }
        }

    }


    /** Checks if the current site is filled by checking whether it's
     *  connected with the top site.
     *
     * TO PREVENT BACKWASH, ONLY USE wquf2 IN THIS METHOD!
     *
     * @param row the row of the site
     * @param col the column of the site
     * @return true if the site is full, false otherwise
     */
    public boolean isFull(int row, int col) {
        /** Check first whether the site is open.
         *
         */
        if (isOpen(row, col)) {
            /**
             * Then check if the site is connected
             * to site 0 (top row)
             */
            int current = convert2Dto1D(row, col);
            return wquf2.connected(current, 0);
        }

        /** If the site is not open, obviously
         *  it's not filled.
         */
        return false;
    }

    /**
     * Returns the current number of open sites.
     */
    public int numberOfOpenSites() {
        return openSites;
    }

    /**
     * Checks if the system percolates. The system percolates when there
     * exists a path that connects the top blocks to the bottom such that
     * water reaches the bottom.
     *
     * USES ONLY THE MAIN WQUF TO CHECK WHETHER SYSTEM PERCOLATES.
     *
     * @return true if the system percolates, false otherwise.
     */
    public boolean percolates() {
        return connected(0, length * length - 1);
    }

    public static void main(String[] args) {

    }
}
