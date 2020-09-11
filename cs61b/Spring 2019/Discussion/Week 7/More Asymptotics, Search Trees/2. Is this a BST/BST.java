public class BST {
    public static class TreeNode{
        int val;
        TreeNode left;
        TreeNode right;

        public TreeNode(int x){
            val = x;
        }
    }

    public static TreeNode root;

    public BST(int x){
        root = new TreeNode(x);
    }

    public static TreeNode treeNodeConstructor(int x){
        return new TreeNode(x);
    }

    /** The method 'buggyIsBST' was written with the logic of
     * making sure that every (currently selected) value is:
     * 1. Greater than its left child
     * 2. Less than its right child
     *
     * However, these conditions are not enough!
     *
     */
    public static boolean buggyIsBST(TreeNode T){
        if (T == null) return true;
        else if (T.left != null && T.left.val > T.val) return false;
        else if (T.right != null && T.right.val < T.val) return false;
        else return buggyIsBST(T.left) && buggyIsBST(T.right);
    }

    /** Instead, we need to check that every (currently selected) value is:
     * 1. Greater than every value in the left subtree
     * 2. Less than every value in the right subtree
     *
     * What it means is that if we are looking (eyeball) a value, it should be:
     * 1. Greater than all the other numbers that are on its left side
     * 2. Less than all other numbers that are on its right side
     * Regardless if its a parent node or child node.
     *
     */
    public static boolean isBST(TreeNode T){
        return isBSTHelper(root, Integer.MIN_VALUE, Integer.MAX_VALUE);
    }

    public static boolean isBSTHelper(TreeNode T, int min, int max){
        if (T == null) return true;
        else if (T.val < min || T.val > max) return false;
        /** Recursively call isBSTHelper on left and right node by changing the
         * min and max threshold.
         * 1. If going through left child, change the 'max' = T.val because we don't want
         * the left child value to be greater than its parent.
         * 2. If going through right child, change the 'min' = T.val. We don't want the
         * right child value to be less than its parent.
         *
         */
        else return isBSTHelper(T.left, min, T.val) && isBSTHelper(T.right, T.val, max);
    }
}


