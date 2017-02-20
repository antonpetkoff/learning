package red.black.tree;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

public class RedBlackTree<K extends Comparable<K>, V> implements IRedBlackTree<K, V>, Iterable<V> {
 
    // TODO: access modifiers and nested classes
    public static final boolean RED = true;
    public static final boolean BLACK = false;
    
    public class Node {
        boolean color;
        Node p, left, right;
        K key;
        V value;
        
        public Node() {
            
        }
        
        public Node(K key, V value, boolean color) {
            this.key = key;
            this.value = value;
            this.color = color;
            this.left = nil;
            this.right = nil;
        }
        
        @Override
        public boolean equals(Object obj) {
            if (obj == null) {
                return false;
            }
            if (this == obj) {
                return true;
            }
            if (obj instanceof RedBlackTree.Node) {
                @SuppressWarnings("unchecked")
                Node o = (Node) obj;
                return key.equals(o.key) && value.equals(o.value) && color == o.color
                        && left == o.left && right == o.right;
            }
            return false;
        }
        
        @Override
        public String toString() {
            return "[" + key+ ", " + (color == RED ? "RED" : "BLACK")
                    + ", " + (p == null ? "null parent" : "has parent") + "]";
        }
    }
    
    public class BstPrinter<KK extends Comparable<KK>, VV> {

        public RedBlackTree<KK, VV>.Node root;
        
        public BstPrinter(RedBlackTree<KK, VV>.Node root) {
            this.root = root;
        }
        
        public void printTree() {
            int maxLevel = maxLevel(root);
            printNodeInternal(Collections.singletonList(root), 1, maxLevel);
        }

        @SuppressWarnings("unchecked")
        private void printNodeInternal(List<RedBlackTree<KK, VV>.Node> nodes, int level, int maxLevel) {
            if (nodes.isEmpty() || areAllNodesNil(nodes))
                return;

            int floor = maxLevel - level;
            int endgeLines = (int) Math.pow(2, (Math.max(floor - 1, 0)));
            int firstSpaces = (int) Math.pow(2, (floor)) - 1;
            int betweenSpaces = (int) Math.pow(2, (floor + 1)) - 1;

            printWhitespaces(firstSpaces);

            List<RedBlackTree<KK, VV>.Node> newNodes = new ArrayList<RedBlackTree<KK, VV>.Node>();
            for (RedBlackTree<KK, VV>.Node node : nodes) {
                if (node != nil) {
                    System.out.print(node.key + (node.color == RED ? "R" : "B"));
                    newNodes.add(node.left);
                    newNodes.add(node.right);
                } else {
                    newNodes.add((RedBlackTree<KK, VV>.Node) nil);
                    newNodes.add((RedBlackTree<KK, VV>.Node) nil);
                    System.out.print(" ");
                }

                printWhitespaces(betweenSpaces);
            }
            System.out.println("");

            for (int i = 1; i <= endgeLines; i++) {
                for (int j = 0; j < nodes.size(); j++) {
                    printWhitespaces(firstSpaces - i);
                    if (nodes.get(j) == nil) {
                        printWhitespaces(endgeLines + endgeLines + i + 1);
                        continue;
                    }

                    if (nodes.get(j).left != nil)
                        System.out.print("/");
                    else
                        printWhitespaces(1);

                    printWhitespaces(i + i - 1);

                    if (nodes.get(j).right != nil)
                        System.out.print("\\");
                    else
                        printWhitespaces(1);

                    printWhitespaces(endgeLines + endgeLines - i);
                }

                System.out.println("");
            }

            printNodeInternal(newNodes, level + 1, maxLevel);
        }

        private void printWhitespaces(int count) {
            for (int i = 0; i < count; i++)
                System.out.print(" ");
        }

        private int maxLevel(RedBlackTree<KK, VV>.Node node) {
            if (node == nil)
                return 0;

            return Math.max(maxLevel(node.left), maxLevel(node.right)) + 1;
        }

        private boolean areAllNodesNil(List<RedBlackTree<KK, VV>.Node> list) {
            for (RedBlackTree<KK, VV>.Node node : list) {
                if (node != nil)
                    return false;
            }
            return true;
        }

    }
    
    private final Node nil;   // acts as a black sentinel, instead of null we use this guard
    private Node root;
    private int size;
    
    public RedBlackTree() {
        nil = new Node();
        nil.color = BLACK;
        root = nil;
    }
    
    public Node createNode(K key, V value, boolean color) {
        return new Node(key, value, color);
    }
    
    public void printTree() {
        BstPrinter<K, V> printer = new BstPrinter<K, V>(root);
        printer.printTree();
    }
    
    public void printNode(Node node) {
        (new BstPrinter<K, V>(node)).printTree();
    }
    
    // precondition: y is x's non-null right child
    void leftRotate(Node x) {
        Node y = x.right;
        x.right = y.left;           // 1) make y's left subtree be x's right subtree
        if (y.left != nil) {
            y.left.p = x;
        }
        y.p = x.p;                  // 2) make y's parent be x's parent
        if (x.p == nil) {
            root = y;
        } else if (x == x.p.left) { // y is left child
            x.p.left = y;
        } else {                    // y is right child
            x.p.right = y;
        }
        x.p = y;                    // 3) x and y switch levels
        y.left = x;
    }
    
    // precondition: x is y's non-null left child
    void rightRotate(Node y) {
        Node x = y.left;
        y.left = x.right;           // 1) make x's right subtree be y's left subtree
        if (x.right != nil) {
            x.right.p = y;
        }
        x.p = y.p;                  // 2) make y's parent be x's parent
        if (y.p == nil) {
            root = x;
        } else if (y == y.p.left) { // x is left child
            y.p.left = x;
        } else {                    // x is right child
            y.p.right = x;
        }
        y.p = x;                    // 3) x and y switch levels
        x.right = y;
    }
    
    /**
     * Replace the subtree rooted at u with the subtree rooted at v.
     * @param u     the root of the subtree to be replaced
     * @param v     the root of the replacement subtree
     */
    void transplant(Node u, Node v) {
        if (u.p == nil) {
            root = v;
        } else if (u == u.p.left) {
            u.p.left = v;
        } else {
            u.p.right = v;
        }
        v.p = u.p;
    }
    
    /**
     * Gets the (non-null) node with the smallest key (left-most leaf) in the given subtree.
     * @param x the subtree from which to take the minimum element
     * @return  the node with the smallest key (left-most leaf) in the given subtree
     */
    private Node treeMinimum(Node x) {
        Node iter = x;
        while (iter.left != nil) {
            iter = iter.left;
        }
        return iter;
    }
    
    /**
     * Find (the first) node matching the given key.
     * @param key   The key which the found node must match
     * @return      The node matching the given key or null if the node doesn't exist.
     */
    private Node findNode(K key) {
        Node iter = root;
        while (iter != nil && !iter.key.equals(key)) {
            int comp = iter.key.compareTo(key);
            if (comp < 0) {
                iter = iter.right;
            } else if (comp > 0) {
                iter = iter.left;
            } else {
                break;
            }
        }
        return iter;    // the found node or null if not found
    }
    
    /**
     * Balancing procedure which restores the properties of the Red-Black Tree
     * after insertion.
     * @param z     The node from which the balancing will start.
     */
    private void insertBalanceUp(Node z) {
        Node uncle = null;
        while (z.p.color == RED) {   // while not root and parent is red
            if (z.p == z.p.p.left) {
                uncle = z.p.p.right;
                if (uncle.color == RED) {   // case 1: flip colors
                    z.p.color = BLACK;
                    uncle.color = BLACK;
                    z.p.p.color = RED;
                    z = z.p.p;
                    continue;
                } else if (z == z.p.right) {    // case 2: transform to case 3
                    z = z.p;
                    leftRotate(z);
                }
                z.p.color = BLACK;  // case 3
                z.p.p.color = RED;
                rightRotate(z.p.p);
            } else {
                uncle = z.p.p.left;
                if (uncle.color == RED) {   // case 1: flip colors
                    z.p.color = BLACK;
                    uncle.color = BLACK;
                    z.p.p.color = RED;
                    z = z.p.p;
                    continue;
                } else if (z == z.p.left) { // case 2: transform to case 3
                    z = z.p;
                    rightRotate(z);
                }
                z.p.color = BLACK;  // case 3
                z.p.p.color = RED;
                leftRotate(z.p.p);
            }
        }
        root.color = BLACK;
    }
    
    @Override
    public void insert(K key, V value) {
        size += insertNode(new Node(key, value, RED)) ? 1 : 0;
    }
    
    private boolean insertNode(Node newNode) {
        Node iter = root, parent = nil;
        while (iter != nil) {
            parent = iter;
            int comp = newNode.key.compareTo(iter.key);
            if (comp < 0) {
                iter = iter.left;
            } else if (comp > 0) {
                iter = iter.right;
            } else {
                return false;   // currently equal elements won't be added
            }
        }
        
        newNode.p = parent;
        if (parent == nil) {
            root = newNode;
        } else if (newNode.key.compareTo(parent.key) < 0) {
            parent.left = newNode;
        } else if (newNode.key.compareTo(parent.key) > 0) {
            parent.right = newNode;
        }
        
        insertBalanceUp(newNode);
        return true;
    }

    @Override
    public void remove(K key) {
        Node target = findNode(key);
        if (target != nil) {
            removeNode(target);
            --size;
        }
    }
    
    private void removeNode(Node z) {
        Node y = z;     // y holds the removed node for now
        Node x = null;  // x is the node which moves into y's original position
        boolean y_original_color = y.color;
        if (z.left == nil) {   // if z has no children or only right child
            x = z.right;
            transplant(z, z.right);
        } else if (z.right == nil) {   // if z has only a left child
            x = z.left;
            transplant(z, z.left);
        } else {    // if z has two children
            // TODO: test the two cases of treeMinimum
            y = treeMinimum(z.right);   // from here on y is the direct replacement of z
            y_original_color = y.color; // the color might be different
            x = y.right;
            if (y.p == z) { // if z's replacement is its right child (direct successor)
                x.p = y;    // x may be a null leaf
            } else {
                transplant(y, y.right);
                y.right = z.right;
                y.right.p = y;
            }
            transplant(z, y);
            y.left = z.left;
            y.left.p = y;
            y.color = z.color;
        }
        if (y_original_color == BLACK) {
            removeBalanceUp(x);
        }
    }

    // null leafs are black by definition
    private boolean isLeftChildBlack(Node x) {
        if (x == null) {
            throw new IllegalArgumentException("The passed node is null and can't have children!");
        }
        return x.left == nil || x.left.color == BLACK;
    }
    
    // null leafs are black by definition
    private boolean isRightChildBlack(Node x) {
        if (x == null) {
            throw new IllegalArgumentException("The passed node is null and can't have children!");
        }
        return x.right == nil || x.right.color == BLACK;
    }
    
    /**
     * A precodure which restores the Red-Black properties of the tree after
     * node removal. The procedure balances the tree from the given node up to the root.
     * @param x     The node from which to start the balancing.
     */
    private void removeBalanceUp(Node x) {
        Node w = null;  // w is the sibling of x
        while (x != root && x.color == BLACK) {
            if (x == x.p.left) {    // x is a left child
                w = x.p.right;
                if (w.color == RED) {   // case 1: x's sibling is red; reduce to cases 2,3 or 4
                    w.color = BLACK;
                    x.p.color = RED;
                    leftRotate(x.p);
                    w = x.p.right;
                }
                
                // case 2: w and both its children are black: take one black off
                if (isLeftChildBlack(w) && isRightChildBlack(w)) {
                    w.color = RED;
                    x = x.p;
                } else if (isRightChildBlack(w)) {
                    // case 3: w is black, w.left is red and w.right is black
                    w.left.color = BLACK;
                    w.color = RED;
                    rightRotate(w);
                    w = x.p.right;
                } else {
                    // case 4: w is black and w.right is red
                    w.color = x.p.color;
                    x.p.color = BLACK;
                    w.right.color = BLACK;
                    leftRotate(x.p);
                    x = root;       // terminate loop
                }
            } else {                // x is a right child
                w = x.p.left;
                if (w.color == RED) {   // case 1: x's sibling is red; reduce to cases 2,3 or 4
                    w.color = BLACK;
                    x.p.color = RED;
                    rightRotate(x.p);
                    w = x.p.left;
                }
                
                // case 2: w and both its children are black: take one black off
                if (isLeftChildBlack(w) && isRightChildBlack(w)) {
                    w.color = RED;
                    x = x.p;
                } else if (isLeftChildBlack(w)) {
                    // case 3: w is black, w.left is black and w.right is red
                    w.right.color = BLACK;
                    w.color = RED;
                    leftRotate(w);
                    w = x.p.left;
                } else {
                    // case 4: w is black and w.left is red
                    w.color = x.p.color;
                    x.p.color = BLACK;
                    w.left.color = BLACK;
                    rightRotate(x.p);
                    x = root;       // terminate loop
                }
            }
        }
        x.color = BLACK;
    }

    @Override
    public V get(K key) {
        if (key == null) throw new NullPointerException("null keys disallowed!");
        Node target = findNode(key);
        return target == nil ? null : target.value;
    }

    @Override
    public boolean contains(K key) {
        return findNode(key) != nil;
    }

    @Override
    public boolean isEmpty() {
        return size == 0;
    }

    @Override
    public int size() {
        return size;
    }

    boolean isBST() {
        return isBST(root);
    }
    
    boolean isBST(Node x) {
        if (x == nil) return true;
        boolean flag = true;
        if (x.left != nil) {
            flag = flag && x.left.key.compareTo(x.key) <= 0 && isBST(x.left);
        }
        if (x.right != nil) {
            flag = flag && x.key.compareTo(x.right.key) <= 0 && isBST(x.right);
        }
        return flag;
    }
    
    boolean areRedParentsCorrect() {
        return areRedParentsCorrect(root);
    }
    
    boolean areRedParentsCorrect(Node x) {
        boolean flag = true;
        if (x != nil && x.color == RED) {
            flag = flag && (x.left.color == BLACK && areRedParentsCorrect(x.left))
                        && (x.right.color == BLACK && areRedParentsCorrect(x.right));
        }
        return flag;
    }
    
    boolean areBlackHeightsCorrect() {
        int blackHeight = 0;
        Node iter = root;
        while (iter != nil) {
            if (iter.color == BLACK) ++blackHeight;
            iter = iter.left;
        }
        return areBlackHeightsCorrect(root, blackHeight);
    }
    
    boolean areBlackHeightsCorrect(Node x, int height) {
        if (x == nil)   return height == 0;
        if (x.color == BLACK) {
            --height;
        }
        return areBlackHeightsCorrect(x.left, height) && areBlackHeightsCorrect(x.right, height);
    }
    
    boolean isRedBlackTree() {
        return root == nil ? true :
            (root.color == BLACK && isBST() && areRedParentsCorrect() && areBlackHeightsCorrect());
    }
    
    public class RedBlackTreeIterator implements Iterator<V> {

        private Node head;
        
        public RedBlackTreeIterator() {
            head = root == nil ? nil : treeMinimum(root);
        }
        
        @Override
        public boolean hasNext() {
            return head != nil;
        }

        @Override
        public V next() {
            V next = head.value;
            
            // prepare next value of head
            if (head.right != nil) {
                head = treeMinimum(head.right);
            } else {
                if (head.p == nil) {    // then head is the root
                    head = nil; // this happens only when the root has no right subtree
                } else if (head == head.p.left) {   // head is a left child
                    head = head.p;
                } else {                // head is a right child
                    // get a parent node with a larger key
                    K key = head.key;
                    while (head.p != nil) {
                        int comp = key.compareTo(head.p.key);
                        head = head.p;
                        if (comp < 0) {
                            break;
                        }
                    }
                    if (key.compareTo(head.key) > 0) {  // if we can't find a key larger than the previous
                        head = nil;
                    }
                }
            }
            
            // return last value of head
            return next;
        }
    }

    @Override
    public Iterator<V> iterator() {
        return new RedBlackTreeIterator();
    }
    
}
