import java.io.FileWriter;
import java.io.IOException;

public class Practical9 {

    public static void main(String[] args) {
        String fileName = "output.txt";

        try {
            FileWriter writer = new FileWriter(fileName);

            writer.write('A');
            writer.write('\n');  

            writer.write("Hello, this is a string being written to the file.");
            writer.write('\n');  

            char[] charArray = { 'J', 'a', 'v', 'a', ' ', 'I', 'O' };
            writer.write(charArray);

            writer.close();

            System.out.println("Data successfully written to the file: " + fileName);

        } catch (IOException e) {
            System.out.println("An error occurred while writing to the file.");
            e.printStackTrace();
        }
    }
}
