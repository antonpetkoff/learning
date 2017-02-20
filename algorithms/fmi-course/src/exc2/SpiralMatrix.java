package exc2;

import java.util.Scanner;

public class SpiralMatrix {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = scanner.nextInt();
        scanner.close();
        int[][] matrix = new int[n][n];
        int iterations = (int) Math.ceil(n / 2.0), j = 0, number = 1, side = n;

        for (int i = 0; i < iterations; ++i) {
            for (j = 0; j < side; ++j) {            // go right
                matrix[i][i+j] = number++;
            }
            for (j = 1; j < side; ++j) {            // go down
                matrix[i+j][n-i-1] = number++;      // n-i-1 is fixed inside this for
            }
            for (j = side - 2; j > -1; --j) {       // go left
                matrix[n-i-1][i+j] = number++;
            }
            for (j = side - 2; j > 0; --j) {        // go up
                matrix[i+j][i] = number++;
            }
            side -= 2;
        }
        
        for (int row = 0; row < n; ++row) {
            for (int col = 0; col < n; ++col) {
                System.out.printf("%4d", matrix[row][col]);
            }
            System.out.println();
        }
    }
    
}
