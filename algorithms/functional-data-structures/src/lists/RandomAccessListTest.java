package lists;

import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static junit.framework.Assert.*;
import static lists.RandomAccessList.*;

public class RandomAccessListTest {

    // step can be +1 or -1
    private static void equalsRange(List<Integer> list, int start, int stop, int step) {
        assertEquals(Math.abs(stop - start + step), list.size());

        for (int e = start, i = 0; e != stop; e += step, ++i) {
            assertEquals(e, (int) list.get(i));
        }
    }

    @org.junit.Test
    public void testIsEmpty() throws Exception {
        assertTrue(isEmpty(empty()));

        assertFalse(isEmpty(cons(1, empty())));
    }

    @org.junit.Test
    public void testCons() throws Exception {
        Tree ral = empty();
        for (int i = 1; i <= 1000; ++i) {
            ral = cons(i, ral);
            assertEquals(i, size(ral));
            equalsRange(ral.toList(), i, 1, -1);
        }
    }

    @org.junit.Test
    public void testHeadTail() throws Exception {
        final int ITER = 1000;

        Tree ral = empty();
        for (int i = ITER; i > 0; --i) {
            ral = cons(i, ral);
        }

        for (int i = 1; i <= ITER; ++i) {
            assertEquals(i, head(ral));
            assertEquals(ITER - i + 1, size(ral));
            equalsRange(ral.toList(), i, ITER, 1);
            ral = tail(ral);
        }
    }

    @org.junit.Test
    public void testGet() throws Exception {
        final int ITER = 1000;

        Tree ral = empty();
        for (int i = ITER - 1; i >= 0; --i) {
            ral = cons(i, ral);
        }

        for (int i = 0; i < ITER; ++i) {
            assertEquals(i, get(ral, i));
        }
    }

    @org.junit.Test
    public void testUpdate() throws Exception {
        final int ITER = 1000;
        Random rand = new Random();

        Tree ral = empty();
        for (int i = ITER; i > 0; --i) {
            ral = cons(i, ral);
        }

        List<Integer> list = IntStream.rangeClosed(1, ITER).boxed().collect(Collectors.toList());
        for (int i = 0; i < ITER; ++i) {
            int index = rand.nextInt(ITER);
            int value = rand.nextInt(ITER);

            ral = update(ral, index, value);
            list.set(index, value);

            assertTrue(list.equals(ral.toList()));
        }
    }

}