package easy.bitpositions;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            String[] input = line.trim().split(",");
        	String binary = Integer.toBinaryString(Integer.parseInt(input[0]));
        	int p1 = binary.length()-Integer.parseInt(input[1]);
        	int p2 = binary.length()-Integer.parseInt(input[2]);
        	System.out.println(binary.charAt(p1) == binary.charAt(p2)?"true":"false");
        }
    }
}