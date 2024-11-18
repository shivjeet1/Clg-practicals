import java.util.Scanner;

public class Instancemethod{
    public static void main(String []args)
    {
        jadu obj1 = new jadu(); //creating an object of class jadu (instance method)
        obj1.print();
    }
}

class jadu{
    Scanner scan = new Scanner(System.in);

    void print(){
        System.out.println("Enter Two numbers");
        int a = scan.nextInt();
        int b = scan.nextInt();
        System.out.println("The Maximum Number is "+Math.max(a, b));
    }
}
