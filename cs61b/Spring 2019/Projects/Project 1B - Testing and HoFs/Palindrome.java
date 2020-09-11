/**
 * Palindrome class
 * @author Ronald Yonggi
 */
public class Palindrome {
    /**
     * Converts an input string to a deque containing the characters of the string
     * @param word the string to be converted into a deque
     * @return the resulting deque
     */
    public Deque<Character> wordToDeque(String word) {
        LinkedListDeque<Character> result = new LinkedListDeque<>();
        for (int i = 0; i < word.length(); i++) {
            result.addLast(word.charAt(i));
        }
        return result;
    }

    /**
     * Checks if a word is a palindrome
     * @param word the word to check if it's a palindrome
     * @return true if the input word is a palindrome, false otherwise
     */
    public boolean isPalindrome(String word) {
        /**
         * Any word of length 1 or 0 is a palindrome.
         */
        if (word.length() <= 1) {
            return true;
        } else {
            Deque<Character> wordToCheck = wordToDeque(word);
            while (wordToCheck.size() > 1) {
                if (wordToCheck.removeFirst() != wordToCheck.removeLast()) {
                    return false;
                }
            }

        }
        return true;
    }

    /**
     * Overloard isPalindrome method that uses a CharacterComparator
     * @param word the word to be examined if it's a palindrome
     * @param cc CharacterComparator object that has a method that can be
     *           used for comparing characters
     * @return whether the word is a palindrome based on CharacterComparator's
     *          rule
     */
    public boolean isPalindrome(String word, CharacterComparator cc) {
        if (word.length() <= 1) {
            return true;
        } else {
            Deque<Character> wordToCheck = wordToDeque(word);
            while (wordToCheck.size() > 1) {
                if (!cc.equalChars(wordToCheck.removeFirst(), wordToCheck.removeLast())) {
                    return false;
                }
            }
        }
        return true;
    }
}
