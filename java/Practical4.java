public class Practical4 {

    // Method to add two integers
    public int add(int a, int b) {
        return a + b;
    }

    // Method to add three integers
    public int add(int a, int b, int c) {
        return a + b + c;
    }

    // Method to add two doubles
    public double add(double a, double b) {
        return a + b;
    }

    public static void main(String[] args) {
        Practical4 demo = new Practical4();

        // Calling different overloaded add() methods
        System.out.println("Sum of 5 and 10: " + demo.add(5, 10));              // Calls add(int, int)
        System.out.println("Sum of 5, 10, and 15: " + demo.add(5, 10, 15));   // Calls add(int, int, int)
        System.out.println("Sum of 5.5 and 10.5: " + demo.add(5.5, 10.5));    // Calls add(double, double)
    }
}
