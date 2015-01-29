package easy.fizzbuzz;

import java.io.*;

public class Main {
	 public static void main (String[] args) throws IOException {
		 File file = new File(args[0]);
	     BufferedReader buffer = new BufferedReader(new FileReader(file));
	     String line;
	     while ((line = buffer.readLine()) != null) {
	         StringBuffer sb = new StringBuffer();
	         String[] input =  line.trim().split("\\s+");
	         int x = Integer.parseInt(input[0]);
	         int y = Integer.parseInt(input[1]);
	         int num = Integer.parseInt(input[2]);
	         for(int i = 1; i <= num; i++) {
	             if(i%x==0 && i%y==0) {
	                 sb.append("FB ");
	             }
	             else if(i%x==0) {
	        	     sb.append("F ");
	             }
	             else if(i%y==0) {
	        	     sb.append("B ");
	             }
	             else {
	        	     sb.append(i + " ");
	             }
	         }
	         String solution = sb.toString().trim();
	         System.out.println(solution);
	     }
	 }
}
