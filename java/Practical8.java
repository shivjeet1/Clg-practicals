import java.util.Scanner;

public class Practical8 {
    public static void divide(int a, int b) {
        try {
            int result = a / b;
            System.out.println("Result of division: " + result);
        } catch (ArithmeticException e) {
            System.out.println("Error: Cannot divide by zero.");
        } finally {
            System.out.println("Division operation completed.");
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter the numerator: ");
        int num = scanner.nextInt();

        System.out.print("Enter the denominator: ");
        int den = scanner.nextInt();
        System.out.println("");

        divide(num, den);
    }
}
