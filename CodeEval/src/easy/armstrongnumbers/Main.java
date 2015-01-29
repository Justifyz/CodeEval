package easy.armstrongnumbers;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            	char[] num = line.toCharArray();
        	int sum = 0;
        	for(int i = 0; i < num.length; i++) {
        		sum += Math.pow(Character.getNumericValue(num[i]),num.length);
        	}
        	System.out.println(sum==Integer.parseInt(line)?"True":"False");
        }
    }
}
