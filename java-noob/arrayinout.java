import java.util.Scanner;

class Arrayinout
{
public static void main(String[] args)
{
System.out.println("Enter the length of array: ");
Scanner sc = new Scanner(System.in);
int n = sc.nextInt();
int[] a = new int[n];
System.out.println("Enter elements ");
for(int i=0; i < a.length ; i++)
{
a[i] = sc.nextInt();
}

System.out.println("The Elements of array are: ");
for(int i=0 ;i < a.length ; i++)
{
System.out.print("a["+i);
System.out.println( "] = "+a[i]);
}
}
}