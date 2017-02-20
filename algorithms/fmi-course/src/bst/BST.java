package bst;

public class BST {

    BST left;
    BST right;
    int value;
    
    public BST(int value) {
        this.value = value;
    }
    
    public BST binarySearch(int value) {
        if (this.value < value) {
            return this.right != null ? this.right.binarySearch(value) : null;
        } else if (this.value > value) {
            return this.left != null ? this.left.binarySearch(value) : null;
        }
        return this;
    }
}
