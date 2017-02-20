package red.black.tree;

import static org.junit.Assert.*;

import java.util.Random;
//import java.util.TreeSet;

import org.junit.Before;
import org.junit.Test;

public class TestRedBlackTree {

    static final int ITERS = 10000;
    static Random rand = new Random();
    RedBlackTree<Integer, Integer> tree;
    Integer[] arr;

    public static <T> void swap(final T[] array, final int a, final int b) {
        T temp = array[a];
        array[a] = array[b];
        array[b] = temp;
    }
    
    public static <T> void shuffle(T[] array) {
        for (int i = 0; i < array.length; ++i) {
            swap(array, i, i + rand.nextInt(array.length - i));
        }
    }
    
    @Before
    public void setUp() {
        tree = new RedBlackTree<Integer, Integer>();
        
        arr = new Integer[ITERS];
        for (int i = 0; i < ITERS; ++i) {
            arr[i] = i;
        }
        shuffle(arr);
    }
    
    @Test
    public void testLeftRotation() {
        RedBlackTree<Integer, Integer>.Node x = tree.new Node(), y = tree.new Node(), p = tree.new Node(),
                alpha = tree.new Node(), beta = tree.new Node(), gamma = tree.new Node();
        
        x.p = p;
        x.left = alpha;
        alpha.p = x;
        x.right = y;
        y.p = x;
        y.left = beta;
        beta.p = y;
        y.right = gamma;
        gamma.p = y;
        
        tree.leftRotate(x);
        
        assertTrue(y.p == p);
        assertTrue(gamma.p == y);
        assertTrue(y.right == gamma);
        assertTrue(y.left == x);
        assertTrue(x.p == y);
        assertTrue(x.right == beta);
        assertTrue(beta.p == x);
        assertTrue(x.left == alpha);
        assertTrue(alpha.p == x);
    }
    
    @Test
    public void testRightRotation() {
        RedBlackTree<Integer, Integer>.Node x = tree.new Node(), y = tree.new Node(), p = tree.new Node(),
                alpha = tree.new Node(), beta = tree.new Node(), gamma = tree.new Node();
        
        // notice that the assignments are the same as the assertions in the test for left rotation
        y.p = p;
        gamma.p = y;
        y.right = gamma;
        y.left = x;
        x.p = y;
        x.right = beta;
        beta.p = x;
        x.left = alpha;
        alpha.p = x;
        
        tree.rightRotate(y);
        
        // notice that the assertions are the same as the assignments in the test for left rotation
        assertTrue(x.p == p);
        assertTrue(x.left == alpha);
        assertTrue(alpha.p == x);
        assertTrue(x.right == y);
        assertTrue(y.p == x);
        assertTrue(y.left == beta);
        assertTrue(beta.p == y);
        assertTrue(y.right == gamma);
        assertTrue(gamma.p == y);
    }
    
    @Test
    public void testTransplant() {
        // alpha < x < p < beta < y < gamma
        RedBlackTree<Integer, Integer>.Node x = tree.new Node(), y = tree.new Node(), p = tree.new Node(),
                alpha = tree.new Node(), beta = tree.new Node(), gamma = tree.new Node();
        
        x.p = p;
        p.left = x;
        x.left = alpha;
        alpha.p = x;
        x.right = y;
        y.p = x;
        y.left = beta;
        beta.p = y;
        y.right = gamma;
        gamma.p = y;
        
        tree.transplant(x, y);
        
        assertTrue(p.left == y);
        assertTrue(y.p == p);
        assertTrue(y.left == beta);
        assertTrue(beta.p == y);
        assertTrue(y.right == gamma);
        assertTrue(gamma.p == y);
    }
    
    public void insertElements() {
        assertTrue(tree.isRedBlackTree());
        assertEquals(0, tree.size());
        for (int i = 0; i < ITERS; ++i) {
            tree.insert(arr[i], arr[i]);
            assertTrue(tree.isRedBlackTree());
            assertEquals(i + 1, tree.size());
            assertEquals(arr[i], tree.get(arr[i]));
            assertTrue(tree.contains(arr[i]));
        }
        assertTrue(tree.isRedBlackTree());
    }
    
    @Test
    public void testInsertion() {
        insertElements();
    }
    
    @Test
    public void testRemoval() {
        insertElements();
        
        for (int i = 0; i < ITERS; ++i) {
            tree.remove(arr[i]);
            assertTrue(tree.isRedBlackTree());
            assertEquals(null, tree.get(arr[i]));
            assertFalse(tree.contains(arr[i]));
            assertEquals(ITERS - i - 1, tree.size());
        }
        assertTrue(tree.isRedBlackTree());
    }
    
    @Test
    public void testIterator() {
        insertElements();
        int i = 0;
        for (Integer value : tree) {
            assertEquals(Integer.valueOf(i), value);
            ++i;
        }
        assertTrue(tree.isRedBlackTree());
        assertEquals(ITERS, tree.size());
    }
    
    @Test
    public void testInsertionPerformance() {
        int iterations = 1_000_000;
        Integer[] arr = new Integer[iterations];
        for (int i = 0; i < iterations; ++i) {
            arr[i] = i;
        }
        shuffle(arr);
        
//        TreeSet<Integer> set = new TreeSet<Integer>();
        
        for (int i = 0; i < iterations; ++i) {
            tree.insert(arr[i], arr[i]);
//            set.add(arr[i]);
        }
    }
    
    @Test
    public void testInsertSorted() {
        for (int i = 0; i < ITERS; ++i) {
            tree.insert(i, i);
//            assertTrue(tree.isRedBlackTree());
        }
        assertTrue(tree.isRedBlackTree());
        
    }
    
}
