package hw2;

import edu.princeton.cs.introcs.StdRandom;
import edu.princeton.cs.introcs.StdStats;

/**
 * @author Ronald Yonggi
 */

public class PercolationStats {

    /** We repeat the percolation threshold computation T times. Hence we need an array of
     * size T to store the results. Remember that the percolation threshold is
     * "the ith site that makes the system percolates when opened" divided by "the
     * total number of sites".
     */
    private double[] results;

    /** repeatTimes is T.
     */
    private int repeatTimes;

    /** numOpen keeps track of the number of open sites.
     *
     */


    /** PercolationStats constructor.
     *
     * @param N size of the grid
     * @param T number of times computation is repeated
     * @param pf a PercolationFactory instance
     */
    public PercolationStats(int N, int T, PercolationFactory pf){
        repeatTimes = T;
        if (N <= 0 || T <= 0) throw new IllegalArgumentException();
        /** Recall that the results is an array of size T.
         *
         */
        results = new double[T];

        for (int i = 0; i < T; i++){
            /** Keeps track of the number of open sites for one calculation
             * of percolation threshold. For every calculation, we reset
             * numOpen to 0.
             */
            int numOpen = 0;

            /** The PercolationFactor class only have one method: make(N), which
             * is basically a Percolation constructor with NxN grid.
             */
            Percolation newPercol = pf.make(N);

            /** This while loop executes as long as the system
             * doesn't percolate.
             */
            while (!newPercol.percolates()){
                /** Draw a random row and a random column.
                 *
                 */
                int randomRow = StdRandom.uniform(N);
                int randomCol = StdRandom.uniform(N);

                /** If a site is not already open, open the site
                 * and increment numOpen.
                 */
                if (!newPercol.isOpen(randomRow, randomCol)){
                    newPercol.open(randomRow, randomCol);
                    numOpen++;
                }
            }

            /** The execution comes out of while loop once the system percolates. Here
             * we compute ONE CALCULATION of percolation threshold by dividing
             * numOpen with the total number of grids.
             */
            results[i] = (double) numOpen / (N * N);
        }


    }

    /** Calculate the mean, or in the problem statement,
     * the mu (greek letter).
     */
    public double mean(){
        return StdStats.mean(results);
    }

    /** Calculate the standard deviation, or in the problem statement,
     * the sigma (greek letter).
     */
    public double stddev(){
        return StdStats.stddev(results);

    }

    public double confidenceLow(){
        return mean() - ((1.96 * stddev()) / Math.sqrt(repeatTimes));
    }

    public double confidenceHigh(){
        return mean() + ((1.96 * stddev()) / Math.sqrt(repeatTimes));
    }

    /** Main method. Not required but useful to
     * check and see the results.
     */
    public static void main(String[] args){
        PercolationStats p = new PercolationStats(20, 20, new PercolationFactory());
        String mean = "The mean is: ";
        System.out.println(mean + p.mean());
        String stddev = "The standard deviation is: ";
        System.out.println(stddev + p.stddev());
        String low = "The lower interval of the 95% confidence interval is: ";
        System.out.println(low + p.confidenceLow());
        String high = "The higher interval of the 95% confidence interval is: ";
        System.out.println(high + p.confidenceHigh());
    }
}
