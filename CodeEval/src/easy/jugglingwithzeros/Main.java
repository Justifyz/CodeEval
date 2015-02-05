package easy.jugglingwithzeros;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File("input.txt");
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
        	String[] input = line.trim().split("\\s++");
        	StringBuilder sb = new StringBuilder();
        	for(int i = 0; i < input.length; i = i+2) {
        		String code = input[i];
        		String sequence = input[i+1];
        		if(code.equals("0")) {
        			sb.append(sequence);
        		}
        		else if(code.equals("00")) {
        			sequence = sequence.replaceAll("0","1");
        			sb.append(sequence);
        		}
        	}
        	System.out.println(Long.parseLong(sb.toString(),2));
        }
    }
}

