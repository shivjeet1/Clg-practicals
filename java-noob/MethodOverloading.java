import java.util.Scanner;

public class MethodOverloading { //1. Changing the number of argumets
    static int add(int a, int b){
        return a+b;
    }
    static int add(int a, int b, int c){
        return a+b+c;
    }
    public static void main(String[] args) {
        System.out.println("Enter any 3 numbers: ");
        Scanner scan = new Scanner(System.in);
        int a = scan.nextInt();
        int b = scan.nextInt();
        int c = scan.nextInt();
        System.out.println("Addition of first two numbers is: "+(add(a,b)));
        System.out.println("Addition of all numbers is "+(add(a,b,c)));
    }
}
