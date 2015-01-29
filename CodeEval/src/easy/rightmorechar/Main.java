package easy.rightmorechar;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
          boolean found = false;
        	String[] input = line.trim().split(",");
        	if(input.length==1) {
        		System.out.println(-1);
        	}
        	else {
        		 char[] word = input[0].toCharArray();
    	    	 for(int i = word.length-1; i >= 0; i--) {
    	    		 if(String.valueOf(word[i]).equals(input[1])) {
    	    			 System.out.println(i);
    	    			 found = true;
    	    			 break;
    	    		 }
    	    	 }
    	    	 if(!found) {
    	    		 System.out.println(-1);
    	    	 }
        	}
        }
    }
}