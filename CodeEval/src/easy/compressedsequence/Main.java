package easy.compressedsequence;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            StringBuilder sb = new StringBuilder();
        	String[] input = line.trim().split("\\s++");
        	int count = 1;
        	String prevNum = input[0];
        	for(int i = 1; i < input.length; i++) {
        		if(input[i].equals(prevNum)) {
        			count++;
        		}
        		else {
        			sb.append(count + " " + prevNum + " ");
        			prevNum = input[i];
        			count = 1;
        		}
        	}
        	sb.append(count + " " + prevNum + " ");
        	System.out.println(sb.toString().trim());   	
        }
    }
}
