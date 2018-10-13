import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Pattern;

public class MaxTreeSum {

    public static class Node {
        public int value;
        public List<Node> children;

        public Node(int v, List<Node> c) {
            this.value = v;
            this.children = c;
        }

        @Override
        public String toString() {
            StringBuilder sb = new StringBuilder();
            if (this.children != null && this.children.size() > 0) {
                sb.append(this.children.get(0));

                for (int i = 1; i < this.children.size(); ++i) {
                    sb.append(',').append(this.children.get(i));
                }
            }

            return "(" + this.value + "(" + sb.toString() + "))";
        }
    }

    public static Node readTree(Scanner scanner) {
        String c = scanner.next();
        assert c.equals("(");

        StringBuilder numberBuilder = new StringBuilder();
        assert scanner.hasNextInt();
        while (scanner.hasNextInt()) {
            numberBuilder.append(scanner.nextInt());
        }
        int value = Integer.valueOf(numberBuilder.toString());

        // TODO: read any whitespace

        // read children opening brace
        c = scanner.next();
        assert c.equals("(");

        // if the empty node
        if (scanner.hasNext(Pattern.compile("\\)"))) {
            // read the closing brace of the empty children list
            c = scanner.next();
            assert c.equals(")");

            // read the closing brace of the tree itself
            c = scanner.next();
            assert c.equals(")");

            return new Node(value, null);
        }

        // read first child
        Node firstChild = readTree(scanner);
        List<Node> children = new LinkedList<>();
        children.add(firstChild);

        while (scanner.hasNext(",")) {
            c = scanner.next();
            assert c.equals(",");

            children.add(readTree(scanner));
        }

        // read closing brace for children
        c = scanner.next();
        assert c.equals(")");

        // read closing brace for the node
        c = scanner.next();
        assert c.equals(")");

        return new Node(value, children);
    }

    public static void main(String[] args) {
        String text = "(5((9()),(1((4()),(12()),(42())))))";

        Scanner scanner = new Scanner(text);
        scanner.useDelimiter("");

        Node tree = readTree(scanner);
        System.out.println(tree);

        System.out.println("Hello World!");
    }
}
