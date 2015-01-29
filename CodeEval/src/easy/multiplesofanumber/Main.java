package easy.multiplesofanumber;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            String[] nums = line.trim().split(",");
        	int num1 = Integer.parseInt(nums[0]);
        	int num2 = Integer.parseInt(nums[1]);
        	if(num1 < num2) {
        		System.out.println(num2);
        	}
        	else {
        		double limit = Math.ceil((double)num1/num2);
        		for(int i = 1; i <= limit; i++) {
        			int multiple = num2 * i;
        			if(multiple > num1) {
        				System.out.println(multiple);
        			}
        		}
        	}
        }
    }
}
