package sequential.list;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;

public class TestSequentialList {
    
    private SequentialList original;
    private final int N = 1000;
    private Random rand = new Random();
    
    @Before
    public void setUp() {
        original = new SequentialList();
        
        for (int i = 0; i < N; ++i) {
            original.add(i);
        }
    }
    
    @Test
    public void testRemoveAt() {
        final int K = 10;
        SequentialList list = new SequentialList();
        
        for (int i = 0; i < K; i++) {
            list.add(i);
        }
        
        assertEquals(10, list.size());
        list.removeAt(list.get(K - 1));;
        assertEquals(K - 2, list.get(K - 2));
        assertEquals(K - 1, list.size());
        
        list.removeAt(list.get(0));
        assertEquals(1, list.get(0));
        assertEquals(K - 2, list.size());
        
        // the list now is [1, 2, 3, 4, 5, 6, 7, 8]
        list.removeAt(K / 2);
        assertEquals(7, list.get(K / 2));
        assertEquals(K - 3, list.size());
        
        // the list now is [1, 2, 3, 4, 5, 7, 8]
        list.removeAt(-2);
        assertEquals(K - 4, list.size());
        assertEquals(8, list.get(5));
    }
    
    @Test
    public void testRemoveElement() {
        SequentialList list = new SequentialList();
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
        SequentialList copy = original.copy();

        assertEquals(copy.size(), original.size());
        
        for (int i = 0; i < N; ++i) {
            assertEquals(original.get(i), copy.get(i));
        }
    }
    
    @Test
    public void testReverse() {
        SequentialList reversed = original.reverse();
        
        assertEquals(reversed.size(), original.size());
        
        for (int i = 0; i < N; ++i) {
            assertEquals(original.get(i), reversed.get(N - i - 1));
        }
    }
    
    @Test
    public void testEquals() {
        SequentialList copy = original.copy();
        
        assertTrue(original.equals(original));
        assertTrue(original.equals(copy));
        assertTrue(copy.equals(original));
        copy.removeAt(copy.size() - 1);
        assertFalse(original.equals(copy));
        assertTrue(copy.equals(copy));
    }
    
    @Test
    public void testIsPalindrome() {
        SequentialList palindrome = new SequentialList();
        
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
    
    public static boolean isSorted(SequentialList list) {
        for (int i = 1; i < list.size(); ++i) {
            if (list.get(i - 1) > list.get(i)) {
                return false;
            }
        }
        
        return true;
    }
    
    @Test
    public void testSortedMerge() {
        SequentialList randomLengthSorted = new SequentialList();
        
        for (int i = 0; i < N; ++i) {
            if (rand.nextDouble() < 0.5) {
                randomLengthSorted.add(i);
            }
        }
        
        assertTrue(isSorted(original));
        assertTrue(isSorted(randomLengthSorted));
        SequentialList merged = original.sortedMerge(randomLengthSorted);
        assertTrue(isSorted(merged));
        assertEquals(original.size() + randomLengthSorted.size(), merged.size());
    }
    
    public static boolean hasDuplicates(SequentialList list) {
        Set<Integer> set = new HashSet<>();

        for (int i = 0; i < list.size(); i++) {
            if (set.contains(list.get(i))) {
                return true;
            } else {
                set.add(list.get(i));
            }
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
        SequentialList withDuplicates = original.copy();
        for (int i = 0; i < N; ++i) {
            if (rand.nextDouble() < 0.5) {
                withDuplicates.add(i);
            }
        }
        
        SequentialList noDuplicates = withDuplicates.removeDuplicates();
        assertFalse(hasDuplicates(original));
        assertTrue(hasDuplicates(withDuplicates));
        assertFalse(hasDuplicates(noDuplicates));
        assertEquals(original.size(), noDuplicates.size());
    }
    
}
