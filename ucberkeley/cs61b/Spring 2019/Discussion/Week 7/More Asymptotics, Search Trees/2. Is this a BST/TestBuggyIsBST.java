import org.junit.*;



public class TestBuggyIsBST {

    @Test
    public void testBuggyIsBST() {
        BST a = new BST(10);
        /** Creates the following tree:
         *
         *           10
         *         /   \
         *        5    15
         *      /  \
         *     /   \
         *    3    12
         *
         */
        a.root.left = BST.treeNodeConstructor(5);
        a.root.left.left = BST.treeNodeConstructor(3);
        a.root.left.right = BST.treeNodeConstructor(12);
        a.root.right = BST.treeNodeConstructor(15);
        /** Below, we test whether the 'buggyIsBST' is faulty. It is indeed!
         * the tree above is not a BST since 12 is correct with respect to 5 but in the
         * wrong place with respect to 10. Regardless, the method returns true.
         */
        Assert.assertTrue(BST.buggyIsBST(a.root));
        Assert.assertFalse(BST.isBST(a.root));


    }

}
