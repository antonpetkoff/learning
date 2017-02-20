package linked.list;

import static org.junit.Assert.*;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;

public class TestLinkedList {

    private LinkedList original;
    private final int N = 1000;
    private Random rand = new Random();
    
    @Before
    public void setUp() {
        original = new LinkedList();
        
        for (int i = 0; i < N; ++i) {
            original.add(i);
        }
    }
    
    @Test
    public void testRemoveAt() {
        final int K = 10;
        LinkedList list = new LinkedList();
        
        for (int i = 0; i < K; i++) {
            list.add(i);
        }
        
        assertEquals(10, list.size());
        list.removeAt(list.get(K - 1));;
        assertEquals(K - 2, list.get(K - 2).element);
        assertEquals(K - 1, list.size());
        
        list.removeAt(list.get(0));
        assertEquals(1, list.get(0).element);
        assertEquals(K - 2, list.size());
        
        // the list now is [1, 2, 3, 4, 5, 6, 7, 8]
        list.removeAt(list.get(K / 2));
        assertEquals(7, list.get(K / 2).element);
        assertEquals(K - 3, list.size());
    }
    
    @Test
    public void testRemoveElement() {
        LinkedList list = new LinkedList();
        list.add(0);
        list.add(1);
        list.add(2);
        
        assertFalse(list.removeElement(3));
        assertEquals(3, list.size());
        
        assertTrue(list.removeElement(1));
        assertEquals(2, list.size());
    }
    
    @Test
    public void testCopy() {
        assertNotNull(original);
        LinkedList copy = original.copy();

        assertEquals(copy.size(), original.size());
        
        for (int i = 0; i < N; ++i) {
            assertEquals(original.get(i).element, copy.get(i).element);
            assertNotEquals(original.get(i), copy.get(i));
        }
    }
    
    @Test
    public void testReverse() {
        LinkedList reversed = original.reverse();
        
        assertEquals(reversed.size(), original.size());
        
        for (int i = 0; i < N; ++i) {
            assertEquals(original.get(i).element, reversed.get(N - i - 1).element);
            assertNotEquals(original.get(i), reversed.get(N - i - 1));
        }
    }
    
    @Test
    public void testEquals() {
        LinkedList copy = original.copy();
        
        assertTrue(original.equals(original));
        assertTrue(original.equals(copy));
        assertTrue(copy.equals(original));
        copy.removeLast();
        assertFalse(original.equals(copy));
        assertTrue(copy.equals(copy));
    }
    
    @Test
    public void testIsPalindrome() {
        LinkedList palindrome = new LinkedList();
        
        assertTrue(palindrome.isPalindrome());
        palindrome.add(0);
        assertTrue(palindrome.isPalindrome());
        palindrome.add(1);
        assertFalse(palindrome.isPalindrome());
        palindrome.add(2);
        assertFalse(palindrome.isPalindrome());
        palindrome.add(1);
        assertFalse(palindrome.isPalindrome());
        palindrome.add(0);
        assertTrue(palindrome.isPalindrome());  // test odd case
        
        assertTrue(palindrome.removeElement(2));
        // the list now is [0, 1, 1, 0]
        assertTrue(palindrome.isPalindrome());
    }
    
    public static boolean isSorted(LinkedList list) {
        LinkedList.Node iter = list.get(0);
        if (iter == null || iter.right == null) {
            // zero or one elements
            return true;
        }
        int previousValue = iter.element;
        
        while (iter != null) {
            if (iter.element < previousValue) {
                return false;
            }
            iter = iter.right;
        }
        
        return true;
    }
    
    @Test
    public void testSortedMerge() {
        LinkedList randomLengthSorted = new LinkedList();
        
        for (int i = 0; i < N; ++i) {
            if (rand.nextDouble() < 0.5) {
                randomLengthSorted.add(i);
            }
        }
        
        assertTrue(isSorted(original));
        assertTrue(isSorted(randomLengthSorted));
        LinkedList merged = original.sortedMerge(randomLengthSorted);
        assertTrue(isSorted(merged));
        assertEquals(original.size() + randomLengthSorted.size(), merged.size());
    }
    
    public static boolean hasDuplicates(LinkedList list) {
        LinkedList.Node iter = list.get(0);
        Set<Integer> set = new HashSet<>();
        
        while (iter != null) {
            if (set.contains(iter.element)) {
                return true;
            } else {
                set.add(iter.element);
            }
            iter = iter.right;
        }
        
        return false;
    }
    
    @Test
    public void testHasDuplicates() {
        assertFalse(hasDuplicates(original));
        original.add(0);
        assertTrue(hasDuplicates(original));
    }
    
    @Test
    public void testRemoveDuplicates() {
        LinkedList withDuplicates = original.copy();
        for (int i = 0; i < N; ++i) {
            if (rand.nextDouble() < 0.5) {
                withDuplicates.add(i);
            }
        }
        
        LinkedList noDuplicates = withDuplicates.removeDuplicates();
        assertFalse(hasDuplicates(original));
        assertTrue(hasDuplicates(withDuplicates));
        assertFalse(hasDuplicates(noDuplicates));
        assertEquals(original.size(), noDuplicates.size());
    }
    
    @Test
    public void testSplice() {
        LinkedList list = new LinkedList();
        list.add(0);
        list.add(1);
        list.add(5);
        list.add(6);
        
        LinkedList splicable = new LinkedList();
        splicable.add(2);
        splicable.add(3);
        splicable.add(4);
        
        assertEquals(4, list.size());
        list.splice(splicable, list.get(1), list.get(2));
        assertEquals(7, list.size());
        
        for (int i = 0; i < 7; ++i) {
            assertEquals(i, list.get(i).element);
        }
    }
    
    @Test
    public void testSplitAt() {
        assertTrue(N > 5);
        int initialSize = original.size();
        
        LinkedList rightSide = original.splitAt(original.get(5));
        assertEquals(5, original.size());
        assertEquals(initialSize - 5, rightSide.size());
        
        for (int i = 0; i < N - 5; ++i) {
            assertEquals(5 + i, rightSide.get(i).element);
        }
    }
    
}
