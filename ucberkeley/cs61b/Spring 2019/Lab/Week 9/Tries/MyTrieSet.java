import java.util.*;

/**
 * HashMap-Based Trie Implementation.
 *
 * Written by: Ronald Yonggi
 *
 */


/**
 *
 *
 * Each node has 2 attributes: isKey and a HashMap.
 * The HashMap's...
 * 1. ...key contains the string
 * 2. ... value contains another Node
 *
 */


public class MyTrieSet implements TrieSet61B {

    private class Node {
        private boolean isKey;
        /** links = buckets(HashMap) containing (if exists) entries, each contains:
         * ...key : a character / letter
         * ...value: a Node that also contains buckets. This is how tries are chained.
         *
         */
        private Map<Character, Node> links;

        /** Node 1-argument constructor */
        Node(boolean x) {
            isKey = x;
            links = new HashMap<>();
        }

    }

    /** Initially define the root Node as an empty Node with
     * isKey = false.
     */
    private Node root = new Node(false);

    @Override
    public void clear(){
        root = new Node(false);
    }

    /** Checks whether the Trie contains the input 'key'. Uses the
     * self-written containsHelper method.
     */
    @Override
    public boolean contains(String key){
        if (key == null) throw new IllegalArgumentException();
        Node result = containsHelper(key);
        return (result != null && result.isKey);
    }

    /** A helper method for 'contains' method. If it returns...
     * 1. ...a Node, that means we have reached the Node that corresponds to the last
     * letter/character of the String 'key'. If the Node's 'isKey' property is...
     *    ~ ...true, then the input 'key' is indeed contained in the Trie
     *    ~ ...false, then the input 'key' isn't contained in the Trie
     * 2. null, then the input 'key' isn't contained in the Trie.
     *
     */
    private Node containsHelper(String key){
        /** Starts with the root Node. Start scanning the first character / letter in
         * input 'key' and check if it is contained in any of root's HashMap buckets.
         *
         *
         * 1. If no, return null
         * 2. If yes, use the HashMap 'get' method to access that character's 'value',
         * which is a Node containing more buckets leading to (if exists) the input
         * 'key''s next character.
         *
         * Upon scanning the last character / letter of the 'key', if the Node exists,
         * check the node's 'isKey' attribute. If true, then the key is indeed
         * contained in the Trie.
         */
        Node currentNode = root;

        /** Scan through each character / letter in the input 'key'.
         *
         */
        for (int i = 0; i < key.length(); i++){
            char currentLetter = key.charAt(i);
            /** If the current letter is not contained in the current
             * Node's buckets, return null.
             */
            if (!currentNode.links.containsKey(currentLetter)) return null;
            /** If exists a Node that contains the current letter, access
             * that letter's Node and update it to currentNode.
             */
            currentNode = currentNode.links.get(currentLetter);
        }
        /** Once we're out of the for loop, this means we have reached the end of the
         * input string 'key'. Return the last accessed node.
         */
        return currentNode;
    }

    /** Implementation is similar to containsHelper. Start with selecting a
     * starting Node (root) and iterate through each character / letter
     * in 'key'.
     *
     * If the character / letter isn't within the currentNode's available links:
     * 1. If it was the last letter, then create a new Entry where
     * the key is the letter and the value is a Node with 'isKey = true'
     * 2. Otherwise, create a new Entry where the key is the letter and
     * the value is a Node with 'isKey = false'.
     *
     * Then update the currentNode before looping to the next letter
     * of the 'key;.
     *
     */
    @Override
    public void add(String key){
        if (key == null) ;
        else {
            Node currentNode = root;
            for(int i = 0; i < key.length(); i++){
                char currentLetter = key.charAt(i);
                /** If the currentNode doesn't contain the current letter.
                 *
                 */
                if (!(currentNode.links.containsKey(currentLetter))){
                    /** Create a new entry and set the Node's
                     * isKey is false.
                     */
                    currentNode.links.put(currentLetter, new Node(false));
                }
                /** Update the currentNode before iterating through the
                 * next letter in key.
                 */
                currentNode = currentNode.links.get(currentLetter);
                /** If the iterated letter is the last letter of the key, change the Node's
                 * isKey value to true.
                 */
                if (i == key.length()-1) currentNode.isKey = true;
            }
        }

    }

    @Override
    public List<String> keysWithPrefix(String prefix){
        List<String> result = new LinkedList<>();
        /**
         * Call keysWithPrefixHelper with the following starting parameters:
         * - prefix (the input prefix)
         * - 0 (the index where we start iterating each letter of the prefix)
         * - "" (the string that will be inserted into the resulting list
         * - root (the starting node)
         */
        keysWithPrefixHelper(prefix, 0, "", result, root);
        return result;
    }

    /** Helper method for keysWithPrefix.
     *
     * The idea is to iterate through each letter in prefix while on the same time:
     * 1. Add the iterated letter through a resulting string
     * 2. Access the nodes of the iterated letters in the Trie.
     *
     * Once we reach the last letter of the prefix, separately traverse through each branch while
     * adding the letters that have been traversed.
     */
    private void keysWithPrefixHelper(String prefix, int prefixIterate, String result, List<String> L, Node n){
        /** If n is null, then we've reached the last letter possible.
         * Return nothing.
         */
        if (n == null) return;
        /** Of any nodes that we iterate through, if its 'isKey' attribute is True, add
         * the string that we have 'soFar' to the list.
         */
        else if (n.isKey) L.add(result);

        /** Iterate through each letter in prefix and access its node. On the same time, add the resulting string
         * with the letters that have been iterated.
         *
         */
        if (prefixIterate < prefix.length()){
            char currentLetter = prefix.charAt(prefixIterate);
            keysWithPrefixHelper(prefix, prefixIterate + 1, result + currentLetter,  L, n.links.get(currentLetter));
        }
        /** Otherwise if all the letters in prefix have been iterated through, for each letter that branches from
         * the last letter of the prefix, call recursive keysWithPrefixHelper that accesses the letter's node. The recursive calls
         * also adds the resulting string with the iterated letters.
         */
        else {
            for (char currentLetter: n.links.keySet()){
                keysWithPrefixHelper(prefix, prefixIterate, result + currentLetter, L, n.links.get(currentLetter));
            }
        }
    }


    /** Instantiate an empty string. Iterate through each letter in 'key'.
     * For each sequence of letter that is contained in the Trie,
     * add it to the empty string.
     */
    @Override
    public String longestPrefixOf(String key){
        String result = "";
        Node currentNode = root;
        for (int i = 0; i < key.length(); i++){
            char currentLetter = key.charAt(i);
            /** If the current iterated letter doesn't exist in the
             * current Node's links, break through the loop.
             */
            if (!currentNode.links.containsKey(currentLetter)) break;
            result += currentLetter;
            /** Otherwise, add the iterated letter to the result string.
             *
             */
            currentNode = currentNode.links.get(currentLetter);
        }
        return result;
    }
}
