package benchmark;


import lists.RandomAccessList;
import lists.RandomAccessList.Tree;
import vectors.PersistentVector;

import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;

import static lists.RandomAccessList.cons;
import static vectors.PersistentVector.PVector;
import static vectors.PersistentVector.conj;

public class Benchmark {

    public static long listCons(int size) {
        Tree list = RandomAccessList.empty();
        long start = System.nanoTime();

        for (int i = 0; i < size; ++i) {
            list = cons(i, list);
        }

        return System.nanoTime() - start;
    }

    public static long listRandomAccess(int listSize, int accessCount) {
        Tree list = RandomAccessList.empty();
        for (int i = 0; i < listSize; ++i) {
            list = cons(i, list);
        }
        Random rand = new Random();

        long start = System.nanoTime();

        for (int i = 0; i < accessCount; ++i) {
            RandomAccessList.get(list, rand.nextInt(listSize));
        }

        return System.nanoTime() - start;
    }

    public static long listLinearAccess(int listSize) {
        Tree list = RandomAccessList.empty();
        for (int i = 0; i < listSize; ++i) {
            list = cons(i, list);
        }

        long start = System.nanoTime();

        for (int i = 0; i < listSize; ++i) {
            RandomAccessList.get(list, i);
        }

        return System.nanoTime() - start;
    }

    public static long listRandomUpdate(int listSize, int updateCount) {
        Tree list = RandomAccessList.empty();
        for (int i = 0; i < listSize; ++i) {
            list = cons(i, list);
        }
        Random rand = new Random();

        long start = System.nanoTime();

        for (int i = 0; i < updateCount; ++i) {
            list = RandomAccessList.update(list, rand.nextInt(listSize), rand.nextInt(listSize));
        }

        return System.nanoTime() - start;
    }

    public static long listLinearUpdate(int listSize) {
        Tree list = RandomAccessList.empty();
        for (int i = 0; i < listSize; ++i) {
            list = cons(i, list);
        }

        long start = System.nanoTime();

        for (int i = 0; i < listSize; ++i) {
            list = RandomAccessList.update(list, i, i + 1);
        }

        return System.nanoTime() - start;
    }

    public static long listTail(int listSize) {
        Tree list = RandomAccessList.empty();
        for (int i = 0; i < listSize; ++i) {
            list = cons(i, list);
        }

        long start = System.nanoTime();

        for (int i = 0; i < listSize; ++i) {
            list = RandomAccessList.tail(list);
        }

        return System.nanoTime() - start;
    }

    public static long vectorConj(int size) {
        PVector vector = PersistentVector.empty();
        long start = System.nanoTime();

        for (int i = 0; i < size; ++i) {
            vector = conj(vector, i);
        }

        return System.nanoTime() - start;
    }

    public static long vectorRandomAccess(int vectorSize, int accessCount) {
        PVector vector = PersistentVector.empty();
        for (int i = 0; i < vectorSize; ++i) {
            vector = conj(vector, i);
        }
        Random rand = new Random();

        long start = System.nanoTime();

        for (int i = 0; i < accessCount; ++i) {
            PersistentVector.get(vector, rand.nextInt(vectorSize));
        }

        return System.nanoTime() - start;
    }

    public static long vectorLinearAccess(int vectorSize) {
        PVector vector = PersistentVector.empty();
        for (int i = 0; i < vectorSize; ++i) {
            vector = conj(vector, i);
        }

        long start = System.nanoTime();

        for (int i = 0; i < vectorSize; ++i) {
            PersistentVector.get(vector, i);
        }

        return System.nanoTime() - start;
    }

    public static long vectorRandomUpdate(int vectorSize, int updateCount) {
        PVector vector = PersistentVector.empty();
        for (int i = 0; i < vectorSize; ++i) {
            vector = conj(vector, i);
        }
        Random rand = new Random();

        long start = System.nanoTime();

        for (int i = 0; i < updateCount; ++i) {
            vector = PersistentVector.update(vector, rand.nextInt(vectorSize), rand.nextInt(vectorSize));
        }

        return System.nanoTime() - start;
    }

    public static long vectorLinearUpdate(int vectorSize) {
        PVector vector = PersistentVector.empty();
        for (int i = 0; i < vectorSize; ++i) {
            vector = conj(vector, i);
        }

        long start = System.nanoTime();

        for (int i = 0; i < vectorSize; ++i) {
            vector = PersistentVector.update(vector, i, i + 1);
        }

        return System.nanoTime() - start;
    }

    public static long vectorPop(int vectorSize) {
        PVector vector = PersistentVector.empty();
        for (int i = 0; i < vectorSize; ++i) {
            vector = conj(vector, i);
        }

        long start = System.nanoTime();

        for (int i = 0; i < vectorSize; ++i) {
            vector = PersistentVector.pop(vector);
        }

        return System.nanoTime() - start;
    }

    public static ArrayList<Long> repeat(int times, Function<Long, Long> fn) {
        ArrayList<Long> results = new ArrayList<>(times);

        for (int i = 0; i < times; ++i) {
            results.add(fn.apply(42L));
        }

        return results;
    }

    public static double mean(ArrayList<Long> data) {
        return data.stream().mapToDouble(a -> a).average().getAsDouble();
    }

    public static double average(int times, Function<Long, Long> test) {
        return mean(repeat(times, test));
    }

    public static void performTest(String title, int times, Function<Long, Long> test) {
        long nano = (long) average(times, test);
        long ms = TimeUnit.MILLISECONDS.convert(nano, TimeUnit.NANOSECONDS);
        System.out.println(title + "\t" + ms + " ms");
    }

    public static void main(String[] args) {
        final int TIMES = 10;
        final int SIZE = (int) 1e+7;

        System.out.println("structure size = " + SIZE);
        System.out.println("each test is averaged after " + TIMES + " repetitions\n");

        performTest("listCons:\t\t", TIMES, (x) -> listCons(SIZE));
        performTest("listRandomAccess:", TIMES, (x) -> listRandomAccess(SIZE, SIZE));
        performTest("listLinearAccess:", TIMES, (x) -> listLinearAccess(SIZE));
        performTest("listRandomUpdate:", TIMES, (x) -> listRandomUpdate(SIZE, SIZE));
        performTest("listLinearUpdate:", TIMES, (x) -> listLinearUpdate(SIZE));
        performTest("listTail:\t\t", TIMES, (x) -> listTail(SIZE));

        System.out.println();

        performTest("vectorConj:\t\t", TIMES, (x) -> vectorConj(SIZE));
        performTest("vectorRandomAccess:", TIMES, (x) -> vectorRandomAccess(SIZE, SIZE));
        performTest("vectorLinearAccess:", TIMES, (x) -> vectorLinearAccess(SIZE));
        performTest("vectorRandomUpdate:", TIMES, (x) -> vectorRandomUpdate(SIZE, SIZE));
        performTest("vectorLinearUpdate:", TIMES, (x) -> vectorLinearUpdate(SIZE));
        performTest("vectorPop:\t\t", TIMES, (x) -> vectorPop(SIZE));
    }
}
