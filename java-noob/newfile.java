import java.io.*;
class newfile{
public static void main(String[] args)
throws Exception
{
File f = new File("vsm123");
f.mkdir();
System.out.println(f.exists());
}
}