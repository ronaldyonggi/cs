public class OffByOne implements CharacterComparator {
    @Override
    public boolean equalChars(char x, char y) {
        if (x > y) {
            return (x - y == 1);
        } else {
            return (y - x == 1);
        }
    }
}
