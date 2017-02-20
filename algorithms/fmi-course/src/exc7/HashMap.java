package exc7;

public class HashMap {
    
    public static class Entry {
        public String key;
        public int value;
        public Entry next;
        
        public Entry(String k, int v) {
            key = k;
            value = v;
        }
    }

    private Entry[] table;
    private int size;
    
    private static final int INITIAL_SIZE = 16;
    private static final double GROWTH_FACTOR = 1.5;
    
    public HashMap() {
        this.size = 0;
        this.table = new Entry[INITIAL_SIZE];
    }
    
    private int index(String key, int size) {
        return hash(key) % size;
    }
    
    private int hash(String key) {
        int p1 = 23, p2 = 31;
        int result = p1;
        for (int i = 0; i < key.length(); ++i) {
            result += p1 * key.charAt(i) + p2;
        }
        result += p1 * key.length() + p2;
        return result;
    }
    
    public void add(String key, int value) {
        tryGrow();
        int position = index(key, size);
        table[position] = new Entry(key, value);
        size++;
    }
    
    private void tryGrow() {        
        if (size >= table.length) {
            Entry[] newArray = new Entry[(int)(table.length * GROWTH_FACTOR)];
            for (int i = 0; i < table.length; i++) {
                Entry current = table[i];
                int pos = index(current.key, newArray.length);
                newArray[pos] = current;
            }
            table = newArray;
        }
    }
    
    public int size() {
        return size;
    }
    
    public int get(String key) {
        int position = index(key, size);
        return table[position].value;
    }
    
    public static void main(String[] args) {
        
    }
    
}
