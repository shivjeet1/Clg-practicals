import java.io.*;

class newdoc{
public static void main(String[] args) throws Exception
{
File f = new File("abc.txt");
f.createNewFile();
System.out.println(f.exists());
}
}