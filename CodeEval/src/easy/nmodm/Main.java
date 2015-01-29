package easy.nmodm;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
          String[] input = line.trim().split(",");
        	int N = Integer.parseInt(input[0]);
        	int M = Integer.parseInt(input[1]);
        	int num = (int)Math.ceil(N/M);
        	int solution = N-num*M;
        	System.out.println(solution);
        }
    }
}