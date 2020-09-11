import java.util.Formatter;

/** Scheme-like pairs that can be used to form a list of integers.
 *  @author P. N. Hilfinger, with some modifications by Josh Hug
 */
public class IntList {
    /**
     * First element of list.
     */
    public int head;
    /**
     * Remaining elements of list.
     */
    public IntList tail;

    /**
     * A List with head HEAD0 and tail TAIL0.
     */
    public IntList(int head0, IntList tail0) {
        head = head0;
        tail = tail0;
    }

    /**
     * A List with null tail, and head = 0.
     */
    public IntList() {
        /* NOTE: public IntList () { }  would also work. */
        this(0, null);
    }

    /* YOU DO NOT NEED TO LOOK AT ANY CODE BELOW THIS LINE UNTIL
       YOU GET TO THE PROBLEMS YOU NEED TO SOLVE. Search for '2a'
       and you'll be where you need to go. */

    /**
     * Returns a new IntList containing the ints in ARGS.
     */
    public static IntList list(Integer... args) {
        IntList result, p;

        if (args.length > 0) {
            result = new IntList(args[0], null);
        } else {
            return null;
        }

        int k;
        for (k = 1, p = result; k < args.length; k += 1, p = p.tail) {
            p.tail = new IntList(args[k], null);
        }
        return result;
    }

    /**
     * Returns true iff X is an IntList containing the same sequence of ints
     * as THIS. Cannot handle IntLists with cycles.
     */
    @Override
    public boolean equals(Object x) {
        if (!(x instanceof IntList)) {
            return false;
        }
        IntList L = (IntList) x;
        IntList p;

        for (p = this; p != null && L != null; p = p.tail, L = L.tail) {
            if (p.head != L.head) {
                return false;
            }
        }
        if (p != null || L != null) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        return head;
    }


    /**
     * If a cycle exists in the IntList headed by A,
     * return an integer equal to the item number of the
     * location where the cycle is detected (i.e. the smallest item
     * number of an item that is the same as a preceding one.  If
     * there is no cycle, return 0.
     */
    private int detectCycles(IntList A) {
        IntList tortoise = A;
        IntList hare = A;

        if (A == null) {
            return 0;
        }

        int cnt = 0;


        while (true) {
            cnt++;
            if (hare.tail != null) {
                hare = hare.tail.tail;
            } else {
                return 0;
            }

            tortoise = tortoise.tail;

            if (tortoise == null || hare == null) {
                return 0;
            }

            if (hare == tortoise) {
                return cnt;
            }
        }
    }

    @Override
    public String toString() {
        Formatter out = new Formatter();
        String sep;
        sep = "(";
        int cycleLocation = detectCycles(this);
        int cnt = 0;

        for (IntList p = this; p != null; p = p.tail) {
            out.format("%s%d", sep, p.head);
            sep = ", ";

            cnt++;
            if ((cnt > cycleLocation) && (cycleLocation > 0)) {
                out.format("... (cycle exists) ...");
                break;
            }
        }
        out.format(")");
        return out.toString();
    }


    /* DO NOT MODIFY ANYTHING ABOVE THIS LINE! */


    /**
     * Returns a list consisting of the elements of A followed by the
     * elements of B.  May modify items of A. Don't use 'new'.
     */

    static IntList dcatenate(IntList A, IntList B) {
        /**
         * ==== RECURSIVE APPROACH ====
         *
         * Base case: If A is null, then return B.
         *
         * The basis of the recursive case is to mutate A by adding B at the end of A.
         * This can be done by updating A.tail with the result of recursive call of
         * dcatenate(A.tail, B). Once A is mutated (B is added to the end of A), we return A.
         *
         */
        if (A == null) return B;
        else {
            A.tail = dcatenate(A.tail, B);
            return A;
        }
    }

    /**
     * Returns a list consisting of the elements of L starting from
     * position START, and going all the way to the end. The head of the
     * list L is the 0th element of the list.
     * <p>
     * This method should NOT modify the items in L.
     */

    static IntList subTail(IntList L, int start) {
        /** ==== ITERATIVE APPROACH ====
         *
         * Initiate a pointer. Shift the pointer as many times as 'start'. Simply
         * return the pointer in the end.
         */
        if (start < 0) return null;
        IntList pointer = L;
        while (start > 0) {
            pointer = pointer.tail;
            start -= 1;
            /** If 'start' is greater than length of L, just return null
             * once the pointer has reached the end of L.
             */
            if (pointer == null) return pointer;
        }
        return pointer;

        /** ==== RECURSIVE APPROACH ====

        if (L == null | start < 0) {
            return null;
        } else if (start == 0) {
            return new IntList(L.head, subTail(L.tail, start));
        }
        return subTail(L.tail, start - 1);

         */
    }

    /**
     * Returns the sublist consisting of LEN items from list L,
     * beginning with item #START (where the first item is #0).
     * Does not modify the original list elements.
     * <p>
     * If the desired items don't exist, or the program
     * receives negative START or LEN parameters, the behavior
     * of this function is undefined, i.e. you can assume
     * that start and len are always >= 0.
     */

    static IntList sublist(IntList L, int start, int len) {
        /** ==== RECURSIVE APPROACH ====
         *
         * Start by making sure we're starting at the point where start == 0 (this
         * is covered in the "else" clause.
         *
         * Once start = 0, start creating a new IntList while len is still above 0. Once len is 0,
         * stop adding elements and return null.
         *
         */
        if (L == null) return L;
        else if (start == 0){
            if (len > 0) return new IntList(L.head, sublist(L.tail, start, len - 1));
            else return null;
        }
        else {
            /** Shift pointer to the element where start is 0 */
            return sublist(L.tail, start-1, len);
        }
    }

    /**
     * Returns the sublist consisting of LEN items from list L,
     * beginning with item #START (where the first item is #0).
     * May modify the original list elements. Don't use 'new'
     * or the sublist method.
     * As with sublist, you can assume the items requested
     * exist, and that START and LEN are >= 0.
     */
    static IntList dsublist(IntList L, int start, int len) {
        /** ==== RECURSIVE APPROACH ====
         *
         * Similar to 'sublist' and 'dcatenate' method implementation:
         * 1. Shift L so that it's pointing at the element where 'start' is 0
         * 2. Once 'start' is 0, update L.tail with recursive 'dsublist' calls where
         * for each recursive call, 'len' is decremented. If 'len' reaches 0,
         * return null.
         */
        if (L == null) return L;
        else if (start == 0){
            if (len > 0) {
                L.tail = dsublist(L.tail, start, len - 1);
                return L;
            } else {
                /** If 'len' reaches 0, return null. */
                return null;
            }
        } else {
            /** Initially, shift L so that it's pointing at the element where
             * 'start' is 0.
             */
            return dsublist(L.tail, start - 1, len);
        }





















        
        /*
        if (len == 0) {
            return null;
        } else if (start == 0) {
            L.tail = dsublist(L.tail, start, len - 1);
            return L;
        }
        return dsublist(L.tail, start - 1, len);
         */
    }
}
