/** Functions to increment and sum the elements of a WeirdList. */
class WeirdListClient {

    /** Return the result of adding N to each element of L. */
    static WeirdList add(WeirdList L, int n) {
        // REPLACE THIS LINE WITH THE RIGHT ANSWER.
        /**
         * x -> x + n is a syntax for Java lambda expression, where the left side is
         * the lambda operator and the right side is the body.
         */
        return L.map(x -> x + n);
    }

    /** Return the sum of the elements in L. */
    static int sum(WeirdList L) {
        // REPLACE THIS LINE WITH THE RIGHT ANSWER.
        sumFunction x = new sumFunction(0);
        L.map(x);
        return x.returnSum();
    }

    /* As with WeirdList, you'll need to add an additional class or
     * perhaps more for WeirdListClient to work. Again, you may put
     * those classes either inside WeirdListClient as private static
     * classes, or in their own separate files.

     * You are still forbidden to use any of the following:
     *       if, switch, while, for, do, try, or the ?: operator.
     */

    /** the sumFunction class is self written for use
     * in WeirdListClient's sum method.
     *
     */
    private static class sumFunction implements IntUnaryFunction {
        private int sum;

        /** sumFunction constructor. Normally we would start with 0.
         *
         */
        sumFunction(int sum) {
            this.sum = sum;
        }

        /** Override the apply method definition from IntUnaryFunction.
         *
         */
        @Override
        public int apply(int x){
            sum += x;
            return x;
        }

        /** Returns the sum.
         *
         */
        public int returnSum(){
            return sum;
        }
    }
}
