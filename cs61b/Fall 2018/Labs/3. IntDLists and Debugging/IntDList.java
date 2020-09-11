
public class IntDList {

    protected DNode _front, _back;

    public IntDList() {
        _front = _back = null;
    }

    public IntDList(Integer... values) {
        _front = _back = null;
        for (int val : values) {
            insertBack(val);
        }
    }

    /**
     *
     * @return The first value in this list.
     * Throws a NullPointerException if the list is empty.
     */
    public int getFront() {
        return _front._val;
    }

    /**
     *
     * @return The last value in this list.
     * Throws a NullPointerException if the list is empty.
     */
    public int getBack() {
        return _back._val;
    }

    /**
     *
     * @return The number of elements in this list.
     */
    public int size() {
        if (_front == null) return 0;
        int count = 1;
        DNode pointer = _front;
        while (pointer._next != null) {
            pointer = pointer._next;
            count++;
        }
        return count;
    }

    /**
     *
     * @param i index of element to return, where i = 0 returns the first element,
     *          i = 1 returns the second element, i = -1 returns the last element,
     *          i = -2 returns the second to last element, and so on.
     *          You can assume i will always be a valid index, i.e 0 <= i < size
     *          for positive indices and -size <= i < 0 for negative indices.
     * @return The integer value at index i
     */
    public int get(int i) {
        /** If 'i' is 0 or greater, use a pointer starting from the 'front',
         * iterate forward using _next, then return it's _val.
         */
        if (i >= 0){
            DNode pointer = _front;
            for (int k = i; k > 0; k--) {
                pointer = pointer._next;
            }
            return pointer._val;
        } else {
            /** Otherwise, 'i' must be negative. In this case, start the
             * pointer from the 'back' and iterate backwards using _prev
             */
            DNode pointer = _back;
            for(int k = i; k < -1; k++) {
                pointer = pointer._prev;
            }
            return pointer._val;
        }
    }

    /**
     *
     * @param d value to be inserted in the front
     */
    public void insertFront(int d) {
        /** In the case of starting with empty IntDList, the implementation
         * is the same as 'insertBack'.
         */
        if (_back == null) {
            _back = new DNode(null, d, null);
            _front = _back;
        } else {
            /** Update _front */
            _front = new DNode(null, d, _front);
            /** Update _next._prev pointer */
            _front._next._prev = _front;
        }
    }

    /**
     *
      * @param d value to be inserted in the back
     */
    public void insertBack(int d) {
        /** If either _front or _back is null, it means the
         * IntDList is empty. When we do 'insertBack' for the first time,
         * set both _front and _back to be the new 'DNode' that we
         * are adding.
         */
        if (_back == null) {
            _back = new DNode(null, d, null);
            _front = _back;
        } else {
            /** Update _back */
            _back = new DNode(_back, d, null);
            /** Update _back's _prev._next pointer */
            _back._prev._next = _back;
        }
    }

    /**
     * Removes the last item in the IntDList and returns it
     * @return the item that was deleted
     */
    public int deleteBack() {
        int toBeReturned = _back._val;
        /** If there's only 1 element 1 begin with, empty out the IntDList after the method call! */
        if (_front._next == null) _back = _front = null;
        else {
            /** Shift the '_back' pointer to the element before '_back' */
            _back = _back._prev;
            /** If after the deletion we're left with one element, then just update _back._next */
            if (_back._prev == null) _back._next = null;
            else {
                /** Otherwise if after deletion we still have 2 or greater elements, update
                 * both _prev._next and _next
                 */
                _back._prev._next = _back;
                _back._next = null;
            }
        }
        return toBeReturned;
    }


    /**
     *
     * @return a string representation of the IntDList in the form
     *  [] (empty list) or [1, 2], etc.
     *  Hint:
     *  String a = "a";
     *  a += "b";
     *  System.out.println(a); //prints ab
     */
    public String toString() {
        /** Base case: if the IntDList is empty to begin with, just return "[]" */
        if (_front == null) return "[]";
        String result = "[";
        DNode pointer = _front;
        while (pointer._next != null) {
            /** Iterate until the last element. For each iteration, add the string version of '_val'
             * to 'result' as well as the string ", ".
             */
            result += Integer.toString(pointer._val);
            result += ", ";
            pointer = pointer._next;
        }
        /** In the end, add the last string version of '_val' and the closing bracket "]". */
        result += Integer.toString(pointer._val);
        result += "]";
        return result;
    }

    /* DNode is a "static nested class", because we're only using it inside
     * IntDList, so there's no need to put it outside (and "pollute the
     * namespace" with it. This is also referred to as encapsulation.
     * Look it up for more information! */
    protected static class DNode {
        protected DNode _prev;
        protected DNode _next;
        protected int _val;

        protected DNode(int val) {
            this(null, val, null);
        }

        protected DNode(DNode prev, int val, DNode next) {
            _prev = prev;
            _val = val;
            _next = next;
        }
    }

}
