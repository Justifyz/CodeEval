package easy.queryboard;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
         int[][] matrix = new int[256][256];
        while((line = buffer.readLine()) != null) {
        	String[] input = line.trim().split("\\s++");
        	if(input[0].equals("SetRow")) {
        		int dest = Integer.parseInt(input[1]);
            	int value = Integer.parseInt(input[2]);
        		for(int i = 0; i < 256; i++) {
        			matrix[dest][i] = value;
        		}
        	}
        	else if(input[0].equals("SetCol")) {
        		int dest = Integer.parseInt(input[1]);
            	int value = Integer.parseInt(input[2]);
        		for(int i = 0; i < 256; i++) {
        			matrix[i][dest] = value;
        		}
        	}
        	else if(input[0].equals("QueryRow")) {
        		int dest = Integer.parseInt(input[1]);
        		int sum = 0;
        		for(int i = 0; i < 256; i++) {
        			sum += matrix[dest][i];
        		}
        		System.out.println(sum);
        	}
        	else if(input[0].equals("QueryCol")) {
        		int dest = Integer.parseInt(input[1]);
        		int sum = 0;
        		for(int i = 0; i < 256; i++) {
        			sum += matrix[i][dest];
        		}
        		System.out.println(sum);
        	}
        }
    }
}