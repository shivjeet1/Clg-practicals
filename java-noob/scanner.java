import java.util.Scanner;
class scanner
{
public static void main(String[] args)
{
Scanner obj = new Scanner(System.in);
System.out.println("Enter your Name:");
String x = obj.next();
System.out.println("Enter your AGE: ");
int age = obj.nextInt(); //I is capital
System.out.println("Enter you Gender: ");
char g = obj.next().charAt(0); //special case for charAt used
System.out.println("Enter you Phone Number: ");
long pno = obj.nextLong(); //L is capital

System.out.println("Given name is "+x);
System.out.println("Age: "+age);
System.out.println("GenDer: " +g);
System.out.println("Phone Number: "+pno);
}
}