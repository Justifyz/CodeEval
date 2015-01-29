package easy.fibonacciseries;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            int num = Integer.parseInt(line.trim());
            int nthFibNum = findNthFib(num);
            System.out.println(nthFibNum);
        }
    }
    
    public static int findNthFib(int n) {
        if(n == 1) {
            return 1;
        }
        if(n == 0) {
            return 0;
        }
        return findNthFib(n-1) + findNthFib(n-2);
    }
}