package red.black.tree;

// TODO: Iterable<> 
// TODO: complementary methods like min, max, floor...
public interface IRedBlackTree<K, V> {

    void insert(K key, V value);
    
    void remove(K key);
    
    V get(K key);
    
    boolean contains(K key);
    
    boolean isEmpty();
    
    int size();
    
}
