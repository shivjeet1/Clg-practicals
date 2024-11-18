import java.util.Scanner;

public class Constructor {
    public static void main(String[] args) {
        Helo1 helo1 = new Helo1(); //Default Constructor
        Scanner num = new Scanner(System.in);
        int a = num.nextInt();
        int b = num.nextInt();
        Helo2 add = new Helo2( a, b); //parameterized constructor
    }
    
}

class Helo1{
    Helo1() //Default constructor
    {
        System.out.println("Enter any two numbers: \n");
    }
}
 
class Helo2{
    Helo2(int a, int b) //Parameterized Constructor
    {
        System.out.println("Additon of entered numbers is "+(a+b));
        System.out.println("Subtration of given numbers is "+(a-b));
        System.out.println("Multiplication of given numbers is "+(a*b));
        System.out.println("Division may be wrong as the inputs are integers but whatever. \n Division is "+(a/b));
    }
}