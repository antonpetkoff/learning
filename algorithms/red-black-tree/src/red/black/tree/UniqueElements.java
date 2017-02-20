package red.black.tree;

import java.util.Scanner;

public class UniqueElements {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        RedBlackTree<Integer, Integer> set = new RedBlackTree<Integer, Integer>();
        
        int n = scanner.nextInt(), temp = 0;
        for (int i = 0; i < n; ++i) {
            temp = scanner.nextInt();
            set.insert(temp, temp);
        }
        
        for (Integer integer : set) {
            System.out.print(integer + " ");
        }
        
        scanner.close();
    }
    
}
