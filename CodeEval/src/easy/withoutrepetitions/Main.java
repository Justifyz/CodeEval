package easy.withoutrepetitions;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
        	StringBuilder sb = new StringBuilder();
            char[] input = line.trim().toCharArray();
            char previousChar = input[0];
            sb.append(previousChar);
            for(int i = 1; i < input.length; i++) {
            	if(previousChar != input[i]) {
            		previousChar = input[i];
            		sb.append(previousChar);
            	}
            }
            System.out.println(sb.toString());
        }
    }
}
