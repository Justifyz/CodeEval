package easy.penultimateword;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            String[] input = line.trim().split("\\s++");
        	System.out.println(input[input.length-2]);
        }
    }
}