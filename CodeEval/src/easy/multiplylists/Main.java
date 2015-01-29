package easy.multiplylists;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            String[] input = line.trim().split("\\|");
        	String[] list1 = input[0].trim().split("\\s++");
        	String[] list2 = input[1].trim().split("\\s++");
        	for(int i = 0; i < list1.length; i++) {
        		int num1 = Integer.parseInt(list1[i]);
        		int num2 = Integer.parseInt(list2[i]);
        		System.out.print(num1*num2);
        		if(i < list1.length-1) {
        			System.out.print(" ");
        		}
        	}
        	System.out.println();
        }
    }
}