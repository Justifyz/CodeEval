package easy.withoutrepetitions;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File("input.txt");
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
        	StringBuilder sb = new StringBuilder();
            char[] input = line.trim().toCharArray();
            sb.append(input[0]);
            for(int i = 1; i < input.length; i++) {
            	if(input[i] != input[i-1]) {
            		sb.append(input[i]);
            	}
            }
            System.out.println(sb.toString());
        }
    }
}
