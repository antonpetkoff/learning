package linked.list;

import java.util.HashSet;
import java.util.Set;


public class LinkedList {
    
    public static class Node {
        public int element;
        public Node right;
        public Node left;
        
        public Node(int element) {
            this.element = element;
        }
    }
    
    private Node head;
    private Node tail;
    
    public void add(int element) {
        if (this.head == null) {
            this.head = new Node(element);
            this.tail = this.head;
        }
        else {
            Node node = new Node(element);
            this.tail.right = node;
            node.left = this.tail;
            this.tail = node;
        }
    }
    
    public Node get(int index) {
        if (this.head == null)
            return null;
        
        Node current = this.head;
        for (int i = 0; i < index; i++) {
            current = current.right;
        }
        return current;
    }
    
    public Node nodeOf(int element) {
        Node current = this.head;
        while (current != null) {
            if (current.element == element) 
                return current;
            current = current.right;
        }
        return null;
    }
    
    public void insert(int element, Node left) {
        Node node = new Node(element);
        if (left == null) {
            this.head.left = node;
            node.right = this.head;
            this.head = node;
        }
        else {
            node.left = left;
            node.right = left.right;
            left.right = node;
            node.right.left = node;
        }
    }
    
    public int size() {
        int size = 0;
        Node current = this.head;
        while (current != null) {
            size++;
            current = current.right;
        }
        return size;
    }
    
    public void removeFirst() {
        if (head != null) {
            head = head.right;
            if (head != null) {
                head.left = null;
            } else {
                tail = null;        // if the last node was removed
            }
        }
    }
    
    public void removeLast() {
        if (tail != null) {
            tail = tail.left;
            if (tail != null) {
                tail.right = null;
            } else {
                head = null;        // if the last node was removed
            }
        }
    }
    
    // Removes the given node from the list.
    public void removeAt(Node node) {
        if (node.left == null) {            // node is head
            removeFirst();
        } else if (node.right == null) {    // node is tail
            removeLast();
        } else {                            // node is in the middle
            node.left.right = node.right;
            node.right.left = node.left;
        }
    }
    
    /**
     * Removes the first element with value @element if such an element exists
     * and returns true. Otherwise, returns false.
     */
    public boolean removeElement(int element) {
        Node node = nodeOf(element);
        
        if (node != null) {
            removeAt(node);
            return true;
        }
        
        return false;
    }
    
    // Returns a copy of the entire list.
    public LinkedList copy() {
        LinkedList list = new LinkedList();
        Node iter = head;
        
        while (iter != null) {
            list.add(iter.element);
            iter = iter.right;
        }
        
        return list;
    }
    
    // Returns another list that has the same elements as the current list but in reverse order.
    public LinkedList reverse() {
        LinkedList reversed = new LinkedList();
        Node iter = tail;
        
        while (iter != null) {
            reversed.add(iter.element);
            iter = iter.left;
        }
        
        return reversed;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        
        if (obj instanceof LinkedList) {
            LinkedList other = (LinkedList) obj;
            Node thisIter = head, otherIter = other.get(0);
            
            while (thisIter != null && otherIter != null) {
                if (thisIter.element != otherIter.element) {
                    return false;
                }
                thisIter = thisIter.right;
                otherIter = otherIter.right;
            }
            
            // if one of the lists has more elements than the other
            if (thisIter != null || otherIter != null) {
                return false;
            }
            
            return true;
        }
        
        return false;
    }
    
    // Returns true iff the current list is a palindrome.
    public boolean isPalindrome() {
        if (head == null) {
            return true;
        }
        
        Node leftIter = head, rightIter = tail, leftPrev, rightPrev;
        
        while (leftIter != rightIter) {
            if (leftIter.element != rightIter.element) {
                return false;
            }
            
            leftPrev = leftIter;
            leftIter = leftIter.right;
            rightPrev = rightIter;
            rightIter = rightIter.left;
            
            if (leftPrev == rightIter && rightPrev == leftIter) {
                /**
                 * when the list has only one element
                 * or
                 * when the size of the list is an even number
                 */
                return true;
            }
        }
        return true;
    }

    /**
     * Assume that both the current list and @other are sorted, merges
     * the current list and @other to produce another sorted list. 
     * For example, merging {1, 3, 5} with {2, 4, 6} should result in {1, 2, 3, 4, 5, 6}.
     * If one of the inputs is not sorted, the behaviour is undefined.
     */
    public LinkedList sortedMerge(LinkedList other) {        
        LinkedList merged = new LinkedList();
        Node lIter = head, rIter = other.get(0);
        
        while (lIter != null || rIter != null) {
            if (lIter == null) {
                merged.add(rIter.element);
                rIter = rIter.right;
            } else if (rIter == null) {
                merged.add(lIter.element);
                lIter = lIter.right;
            } else if (lIter.element <= rIter.element) {
                merged.add(lIter.element);
                lIter = lIter.right;
            } else {
                merged.add(rIter.element);
                rIter = rIter.right;
            }
        }
        
        return merged;
    }
    
    // Returns a new list that has the same elements as the current one but no duplicates.
    public LinkedList removeDuplicates() {
        LinkedList noDuplicates = new LinkedList();
        Set<Integer> set = new HashSet<>();
        Node iter = head;
        
        while (iter != null) {
            if (!set.contains(iter.element)) {
                set.add(iter.element);
                noDuplicates.add(iter.element);
            }
            iter = iter.right;
        }
        
        return noDuplicates;
    }
    
    /**
     * Inserts all the elements of @other between @start and @end.
     * It is assumed that @start is the left node of @end and
     * @end is the right node of @start.
     * 
     * @param other     the list which elements are spliced in the calling list
     * @param start     the left exclusive border of the spliced elements
     *                  (belongs to the calling list)
     * @param end       the right exclusive border of the spliced elements
     *                  (belongs to the calling list)
     */
    void splice(LinkedList other, Node start, Node end) {
        if (other == null) {
            return;
        }
        if (start == null || end == null || start.right != end
                || end.left != start) {
            throw new IllegalArgumentException("No splice borders defined!");
        }
                
        Node otherStart = other.get(0);
        if (otherStart == null) {
            return;
        }
        
        start.right = otherStart;
        
        Node iter = start.right;
        
        while (iter != null) {
            if (iter.right == null) {
                // connect the end
                iter.right = end;
                end.left = iter;
                break;
            }
            iter = iter.right;
        }
    }
    
    /**
     * Splits the list at the specified node. The nodes to the left @node
     * should remain in the current list.
     * The others are to be returned in another list.
     * 
     * @param node      the node at which the list will be splitted
     * @return          the list with elements right to the @node inclusive
     */
    public LinkedList splitAt(Node node) {
        // remove the right side from the calling list
        tail = node.left;
        tail.right = null;
        
        // create a new list with the right side elements
        LinkedList rightSide = new LinkedList();
        Node iter = node;
        
        while (iter != null) {
            rightSide.add(iter.element);
            iter = iter.right;
        }
        
        return rightSide;
    }
    
}