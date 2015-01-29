package easy.findawriter;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
           StringBuffer sb = new StringBuffer();
        	String[] encoded = line.trim().split("\\|");
        	char[] coded = encoded[0].toCharArray();
        	String[] key = encoded[1].trim().split("\\s+");
        	for(int i = 0; i < key.length; i++) {
        		int position = Integer.parseInt(key[i]);
        		sb.append(coded[position-1]);
        	}
        	System.out.println(sb.toString());
        }
    }
}
