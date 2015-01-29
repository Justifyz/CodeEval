package easy.evennumbers;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            int number = Integer.parseInt(line.trim());
            System.out.println(number%2==0?1:0);
        }
    }
}
