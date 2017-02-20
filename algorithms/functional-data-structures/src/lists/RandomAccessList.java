package lists;

import java.util.LinkedList;
import java.util.List;

public class RandomAccessList {

    public static class Node implements Cloneable {
        int value;
        Node left;
        Node right;

        public Node(int value, Node left, Node right) {
            this.value = value;
            this.left = left;
            this.right = right;
        }

        @Override
        public String toString() {
            String left = this.left == null ? "null" : this.left.toString();
            String right = this.right == null ? "null" : this.right.toString();
            return "(" + left + ", " + this.value + ", " + right + ")";
        }

        @Override
        public Node clone() {
            return new Node(this.value, this.left, this.right);
        }

        public List<Integer> toList() {
            List<Integer> list = new LinkedList<Integer>();

            // pre-order traversal
            list.add(this.value);
            if (this.left != null) {
                list.addAll(this.left.toList());
            }
            if (this.right != null) {
                list.addAll(this.right.toList());
            }

            return list;
        }
    }

    public static class Tree implements Cloneable {
        Node root;
        int size;
        Tree next;

        public Tree(Node root, int size, Tree next) {
            this.root = root;
            this.size = size;
            this.next = next;
        }

        @Override
        public String toString() {
            return "{size = " + this.size + ", root = " + this.root + "}"
                    + (this.next == null ? "" : (", " + this.next.toString()));
        }

        @Override
        public Tree clone() {
            return new Tree(this.root, this.size, this.next);
        }

        public List<Integer> toList() {
            LinkedList<Integer> list = new LinkedList<Integer>();
            Tree head = this;

            while (head != null) {
                list.addAll(head.root.toList());
                head = head.next;
            }

            return list;
        }
    }

    public static Tree empty() {
        return null;
    }

    public static boolean isEmpty(Tree list) {
        return list == empty();
    }

    public static Tree cons(int value, Tree head) {
        Tree tree1 = head;
        Tree tree2 = tree1 != null ? tree1.next : null;
        Tree result = null;

        if (tree1 != null && tree2 != null && tree1.size == tree2.size) {
            Node combinedRoot = new Node(value, tree1.root, tree2.root);
            int combinedSize = tree1.size + tree2.size + 1;
            result = new Tree(combinedRoot, combinedSize, tree2.next);
        } else {
            result = new Tree(new Node(value, null, null), 1, head);
        }

        return result;
    }

    public static int head(Tree list) {
        if (isEmpty(list)) {
            throw new IllegalStateException();
        }

        return list.root.value;
    }

    public static Tree tail(Tree list) {
        if (isEmpty(list)) {
            throw new IllegalStateException();
        }

        Tree result = null;

        if (list.size == 1) {	// XXX: list.size is actually listHead.size
            result = list.next;
        } else {	// the size of the tree is 3, 7, 15, ..., 2^k - 1 for k > 1
            int subTreeSize = list.size / 2;
            Tree tree2 = new Tree(list.root.right, subTreeSize, list.next);
            Tree tree1 = new Tree(list.root.left, subTreeSize, tree2);
            result = tree1;
        }

        return result;
    }

    public static int get(Tree list, int index) {
        if (isEmpty(list)) {
            throw new IndexOutOfBoundsException();
        }

        return forestLookUp(list, index);
    }

    private static int forestLookUp(Tree head, int index) {
        Tree tree = head;

        while (index >= tree.size) {
            index -= tree.size;
            tree = tree.next;
        }

        return treeLookUp(tree.root, tree.size, index);
    }

    private static int treeLookUp(Node root, int size, int index) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException();
        }

        if (index == 0) {
            return root.value;
        } else {
            int subTreeSize = size / 2;

            if (index <= subTreeSize) {
                return treeLookUp(root.left, subTreeSize, index - 1);
            } else {
                return treeLookUp(root.right, subTreeSize, index - 1 - subTreeSize);
            }
        }
    }

    public static Tree update(Tree list, int index, int value) {
        if (isEmpty(list)) {
            throw new IllegalStateException();
        }

        return updateForest(list, index, value);
    }

    // forest path copying
    private static Tree updateForest(Tree listHead, int index, int value) {
        // create a clone and make all modifications on the clone
        Tree updatedList = listHead.clone();

        Tree head = updatedList;    // start forest path copying

        while (index >= head.size) {
            index -= head.size;
            head = head.next = head.next.clone();
        }

        // finish forest path copying by starting in-tree path copying
        head.root = updateTree(head.root, head.size, index, value);

        return updatedList;
    }

    // tree path copying
    private static Node updateTree(Node root, int size, int index, int value) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException();
        }

        if (index == 0) {   // base
            return new Node(value, root.left, root.right);
        }

        // step, clone node and update one branch
        int subTreeSize = size / 2;

        if (index <= subTreeSize) {
            Node updatedLeftSubtree = updateTree(root.left, subTreeSize, index - 1, value);
            return new Node(root.value, updatedLeftSubtree, root.right);
        } else {
            Node updatedRightSubtree = updateTree(root.right, subTreeSize, index - 1 - subTreeSize, value);
            return new Node(root.value, root.left, updatedRightSubtree);
        }
    }

    public static int size(Tree list) {
        Tree head = list;
        int size = 0;

        while (head != null) {
            size += head.size;
            head = head.next;
        }

        return size;
    }

    public static void main(String[] args) {
        Tree list = cons(3, cons(2, cons(1, empty())));
        System.out.println(list);
        System.out.println(get(list, 0));
        System.out.println(tail(list));

        Tree updatedList = update(cons(4, list), 3, 42);
        System.out.println(updatedList);
    }

}
