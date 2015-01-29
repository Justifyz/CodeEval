package easy.rollercoaster;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
        	char[] input = line.trim().toCharArray();
        	boolean rotate = false;
        	for(int i = 0; i < input.length; i++) {
        		if(Character.isLetter(input[i])) {
        			if(!rotate) {
        				input[i] = Character.toUpperCase(input[i]);
        				rotate = true;
        			}
        			else {
        				input[i] = Character.toLowerCase(input[i]);
        				rotate = false;
        			}      			
        		}
        	}
        	System.out.println(String.valueOf(input));
        }
    }
}

