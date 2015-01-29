package easy.reversewords;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            String[] input = line.trim().split("\\s++");
            for(int i = input.length-1; i >= 0; i--) {
                System.out.print(input[i]);
                if(i > 0) {
                    System.out.print(" ");
                }
            }
            System.out.println();
        }
    }
}
