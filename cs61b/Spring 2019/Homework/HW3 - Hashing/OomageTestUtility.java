package hw3.hash;

import java.util.LinkedList;
import java.util.List;

public class OomageTestUtility {
    public static boolean haveNiceHashCodeSpread(List<Oomage> oomages, int M) {
        /* TODO:
         * Write a utility function that returns true if the given oomages
         * have hashCodes that would distribute them fairly evenly across
         * M buckets. To do this, convert each oomage's hashcode in the
         * same way as in the visualizer, i.e. (& 0x7FFFFFFF) % M.
         * and ensure that no bucket has fewer than N / 50
         * Oomages and no bucket has more than N / 2.5 Oomages.
         */

        /** The idea is to create an array of buckets, in which each bucket
         * contains a LinkedList containing Oomages. For each oomage in the input, we do
         * the following:
         * 1. Calculate the bucket index (bucketNum) which that oomage will be assigned to
         * 2. Add that oomage to buckets[bucketNum]
         *
         * Once we've completed adding all the input oomages to the buckets, we check
         * each bucket whether they fulfill the nice spread conditions. If any of
         * the condition is unfulfilled, then return false;
         */


        boolean niceSpread = true; // An indicator of whether we have a nice spread.
        int numOomages = oomages.size(); // Number of oomages in the input

        /** Initiate an array of buckets containing LinkedList of Oomages.
         *
         */
        LinkedList<Oomage>[] buckets = new LinkedList[M];
        for (int i = 0; i < M; i++) buckets[i] = new LinkedList<Oomage>();

        /** For each oomage from the input, calculate its assigned bucket index, then
         * add the oomage to its assigned bucket.
         */
        for (Oomage o: oomages){
            int bucketNum = (o.hashCode() & 0x7FFFFFFF) % M;
            buckets[bucketNum].add(o);
        }

        /** For each bucket, check if the nice spread condition is fulfilled. If any
         * of the condition is unfulfilled, change the 'niceSpread' indicator to
         * false.
         */
        for (LinkedList<Oomage> bucket: buckets){
            if (bucket.size() < (numOomages / 50)) niceSpread = false;
            if (bucket.size() > (numOomages / 2.5)) niceSpread = false;
        }

        return niceSpread;
    }
}
