import java.util.Scanner;
public class Strings{
    public static void main(String[] args){
        Scanner jadu = new Scanner(System.in);
        
        char[] charString = {'S', 't', 'r', 'i', 'n', 'g', 's'};
        
        String str = new String(charString);
        
        System.out.println("The value of Str is: "+str);

        System.out.println("Enter String: ");
        str = jadu.next();
        System.out.println("The value of str is: "+str);

        str = "Java Strings";
        System.out.println("The value of str is: "+str);

        str = "String" + "Concatenate";
        System.out.println("The value of string is: "+str);

        jadu.close();
    }
}