package easy.sumofdigits;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
          	char[] digits = line.trim().toCharArray();
        	int sum = 0;
        	for(int i = 0; i < digits.length; i++) {
        		sum += Integer.parseInt(String.valueOf(digits[i]));
        	}
        	System.out.println(sum);
        }
    }
}
