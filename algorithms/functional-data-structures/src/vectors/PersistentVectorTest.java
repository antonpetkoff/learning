package vectors;

import org.junit.Test;

import java.util.LinkedList;
import java.util.Random;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static vectors.PersistentVector.*;

public class PersistentVectorTest {
    @Test
    public void testIsEmpty() {
        assertTrue(isEmpty(empty()));
    }

    @Test
    public void testConjGet() {
        final int SIZE = 1000;
        PVector vector = empty();

        for (int i = 0; i < SIZE; ++i) {
            vector = conj(vector, i);
            assertEquals(i + 1, vector.size);

            for (int j = 0; j < i; ++j) {
                assertEquals(j, get(vector, j));
            }
        }
    }

    @Test
    public void testUpdate() {
        final int SIZE = 1000;
        PVector vector = empty();
        LinkedList<Integer> list = new LinkedList<>();

        for (int i = 0; i < SIZE; ++i) {
            vector = conj(vector, i);
            list.add(i);
            assertEquals(list.size(), vector.size);
        }

        Random rand = new Random();

        int index, value;
        for (int i = 0; i < SIZE; ++i) {
            index = rand.nextInt(SIZE);
            value = rand.nextInt(SIZE);

            vector = update(vector, index, value);
            list.set(index, value);

            assertEquals((int) list.get(index), get(vector, index));
        }
    }

    @Test
    public void testPop() {
        final int SIZE = 1000;
        PVector vector = empty();
        LinkedList<Integer> list = new LinkedList<>();

        for (int i = 0; i < SIZE; ++i) {
            vector = conj(vector, i);
            list.add(i);
            assertEquals(list.size(), vector.size);
        }

        for (int i = 0; i < SIZE; ++i) {
            vector = pop(vector);
            list.removeLast();

            assertEquals(list.size(), vector.size);

            for (int j = 0; j < list.size(); ++j) {
                assertEquals((int) list.get(j), get(vector, j));
            }
        }
    }
}