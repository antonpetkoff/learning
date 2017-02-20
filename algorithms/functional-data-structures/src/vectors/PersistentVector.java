package vectors;

import java.util.ArrayList;

public class PersistentVector {

    public static final int BITS = 5;
    public static final int BASE = 1 << BITS; // a.k.a branching factor
    public static final int MASK = BASE - 1;

    // TODO: maybe use a Java built-in method
    public static Object[] clone(Object[] array, int size) {
        Object[] copy = new Object[size];

        for (int i = 0; i < BASE; ++i) {
            copy[i] = array[i];
        }

        return copy;
    }

    public static class PVector {
        Object[] root;
        int size;

        public PVector(Object[] root, int size) {
            this.root = root;
            this.size = size;
        }

        @Override
        public String toString() {
            ArrayList<Integer> list = new ArrayList<>(this.size);

            for (int i = 0; i < this.size; ++i) {
                list.add(get(this, i));
            }

            return list.toString();
        }
    }

    public static PVector empty() {
        return new PVector(new Object[BASE], 0);
    }

    public static boolean isEmpty(PVector vector) {
        return vector.size == 0;
    }

    // TODO: closestPowerOfBase(0, 2) under-flows the integer
    private static int closestPowerOfBase(int n, int base) {
        return (int) Math.ceil(Math.log(n) / Math.log(base));
    }

    // how many levels does a tree with `size` leafs have
    private static int getTreeDepth(int size) {
        return size == 0 ? -1 : closestPowerOfBase(size, BASE);
    }

    public static int get(PVector vector, int index) {
        if (index >= vector.size) {
            throw new IndexOutOfBoundsException();
        }

        return (int) getLeafValue(vector, index);
    }

    private static Object getLeafValue(PVector vector, int index) {
        Object[] node = vector.root;
        int shift = BITS * (getTreeDepth(vector.size) - 1);

        for (int level = shift; level > 0; level -= BITS) {
            node = (Object[]) node[(index >>> level) & MASK];
        }

        return node[index & MASK];
    }

    /**
     * (with side effects!)
     *
     * Modify the given tree, represented by its root, by copying the specified path
     * and return the leaf. The passed root then has the copied path.
     *
     * This method would usually work on a copy of the root, i.e. the passed root
     * is a copy of the original root.
     *
     * @param root  Represents the tree which will have a path copied.
     * @param leafCount The count of the leafs in the passed tree.
     *                  Needed for calculating which branches to take from the root to the leaf.
     * @param index Identifies the leaf node uniquely in the given tree (trie).
     * @return {Object[]} The leaf which path from the root has been copied.
     */
    private static Object[] createPathCopiedLeaf(Object[] root, int leafCount, int index) {
        Object[] node = root;   // only node from the root to the leaf will be cloned/created
        int shift = BITS * (getTreeDepth(leafCount) - 1);
        int childBranch;

        for (int level = shift; level > 0; level -= BITS) {
            childBranch = (index >>> level) & MASK;

            if (node[childBranch] == null) { // the child is missing and must be created
                node[childBranch] = new Object[BASE];   // TODO: a more uniform way of creating nodes
            } else {    // the child must be copied
                node[childBranch] = clone((Object[]) node[childBranch], BASE);
            }

            node = (Object[]) node[childBranch];    // move one level down
        }

        return node;    // we have reached the leaf
    }

    private static boolean isPowerOfBase(int n, int base) {
        return n == (int) Math.pow(base, closestPowerOfBase(n, base));
    }

    public static PVector conj(PVector vector, int value) {
        Object[] newRoot = null;
        Object[] pathCopiedLeaf = null;

        if (vector.size < BASE) {   // the root is the leaf
            newRoot = clone(vector.root, BASE);
            pathCopiedLeaf = newRoot;
        } else if (isPowerOfBase(vector.size, BASE)) {  // all leafs are full
            newRoot = new Object[BASE];
            newRoot[0] = vector.root;   // the newRoot adds one more level of depth
            pathCopiedLeaf = createPathCopiedLeaf(newRoot, vector.size + 1, vector.size);
        } else {    // at least one empty leaf exists
            newRoot = clone(vector.root, BASE);
            pathCopiedLeaf = createPathCopiedLeaf(newRoot, vector.size + 1, vector.size);
        }

        pathCopiedLeaf[vector.size & MASK] = value; // append the new value

        return new PVector(newRoot, vector.size + 1);
    }

    public static PVector update(PVector vector, int index, int value) {
        if (index >= vector.size) {
            throw new IndexOutOfBoundsException();
        }

        Object[] newRoot = clone(vector.root, BASE);

        Object[] pathCopiedLeaf = createPathCopiedLeaf(newRoot, vector.size, index);
        pathCopiedLeaf[index & MASK] = value;

        return new PVector(newRoot, vector.size);
    }

    /**
     * (with side effects!)
     *
     * Remove the last leaf node by copying the path to its left sibling leaf.
     *
     * @param root  The root of the tree (trie) which will have a path copied.
     * @param level The level on which the passed root node is at.
     * @param index Defines the path to the first item in the last leaf node which will be removed.
     * @return {Object[]}
     */
    private static Object[] removeLastLeaf(Object[] root, int level, int index) {
        int childBranch = (index >>> level) & MASK;
        Object[] child = (Object[]) root[childBranch];

        if (child[1] == null) { // base: this node has only one path
            // and this path is to the leaf we want to remove
            // => stop recurring down to the leaf
            // note: child could be the leaf itself (the leaf has only 1 item at index 0)

            root[childBranch] = null;
        } else {    // step: there are at least 2 paths from this node => copy it
//            root[childBranch] = copy;
            root[childBranch] = removeLastLeaf(clone(child, BASE), level - BITS, index);
        }

        return root;
    }

    public static PVector pop(PVector vector) {
        if (vector.size == 0) {
            throw new IllegalStateException();
        }

        Object[] newRoot;

        if (vector.size <= BASE) {  // the root is the only leaf
            newRoot = clone(vector.root, BASE);
            newRoot[(vector.size - 1) & MASK] = null;   // remove the last item in the root
        } else if (isPowerOfBase(vector.size - 1, BASE)) { // kill the root, remove top level
            newRoot = (Object[]) vector.root[0];
        } else if (vector.size % BASE == 1) {    // then there is only one item in the last leaf
            // by removing the last leaf we must remove all its empty parents
            int level = BITS * (getTreeDepth(vector.size) - 1);
            newRoot = clone(vector.root, BASE);
            newRoot = removeLastLeaf(newRoot, level, vector.size - 1);
        } else {    // the last leaf has at least 2 items
            // copy the path to the last leaf and update the last item to point to null
            newRoot = clone(vector.root, BASE);
            Object[] lastLeafCopy = createPathCopiedLeaf(newRoot, vector.size, vector.size - 1);
            lastLeafCopy[(vector.size - 1) & MASK] = null;  // remove the last item in the leaf
        }

        return new PVector(newRoot, vector.size - 1);
    }

    public static void main(String[] args) {
        PVector v1 = conj(empty(), 1);
        PVector v2 = conj(v1, 2);
        PVector v3 = conj(v2, 3);
        PVector v4 = conj(v3, 4);
        PVector v5 = conj(v4, 5);

        System.out.println(get(v5, 4));
        System.out.println(v5);

        System.out.println(pop(v3));
    }
}
