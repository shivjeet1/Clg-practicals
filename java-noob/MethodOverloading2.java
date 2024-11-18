import java.util.Scanner;

public class MethodOverloading2 {
    //2. Method Overloadin: changing the datatypes of arguments
    static int add(int a, int b){
        return a+b;
    }
    static double add(double a, double b){
        return a+b;
    }
    public static void main(String[] args) {
        System.out.println("Addition of first two numbers is: "+(add(7,18)));
        System.out.println("Addition of first two numbers is: "+(add(7.9,18.6)));
    }
    
}
