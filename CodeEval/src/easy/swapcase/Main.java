package easy.swapcase;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
           char[] input = line.trim().toCharArray();
        	for(int i = 0; i < input.length; i++) {
        		if(Character.isUpperCase(input[i])) {
        			input[i] = Character.toLowerCase(input[i]);
        		}
        		else {
        			input[i] = Character.toUpperCase(input[i]);
        		}
        	}
        	System.out.println(String.valueOf(input));  	
        }
    }
}
