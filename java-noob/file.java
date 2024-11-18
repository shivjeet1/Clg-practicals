import java.io.*;
class Main
{
public static void main(String[] args)
{
FileReader file = new FileReader("C:\\test\\a.txt");
BufferedReader fileInput = new BufferedReader(file);
// Print first 3 lines of file "C:\test\a.txt"
for (int counter = 0; counter < 3; counter++)
System.out.println(fileInput.readLine());
fileInput.close();
}
} 