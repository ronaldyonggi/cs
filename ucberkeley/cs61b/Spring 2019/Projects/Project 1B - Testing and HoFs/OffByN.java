public class OffByN implements CharacterComparator {
    private int n;

    /**
     * OffByN Character Comparator constructor
     * @param N the offset
     */
    public OffByN(int N) {
        n = N;
    }

    /**
     * Overridden equalChars method for OffByN class
     * @param x the first character to be compared
     * @param y the second character to be compared
     * @return true if the offset of the characters is N. Otherwise returns
     *          false
     */
    @Override
    public boolean equalChars(char x, char y){
        if (x > y) {
            return (x - y == n);
        } else {
            return (y - x == n);
        }
    }

}
