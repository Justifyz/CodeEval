package easy.happynumbers;
import java.io.*;
import java.util.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            ArrayList<Integer> list = new ArrayList<Integer>();
            line= line.trim();
            char[] digits = line.toCharArray();
            boolean isHappy = false;
            while(true) {
                int sum = 0;
                for(int i = 0; i < digits.length; i++) {
                    sum += Math.pow(Integer.parseInt("" + digits[i]),2);
                }
                if(sum == 1) {
                    isHappy = true;
                    break;
                }
                if(list.contains(sum)) {
                    isHappy = false;
                    break;
                }
                else {
                    list.add(sum);
                    String newNum = String.valueOf(sum);
                    digits = newNum.toCharArray();
                }
            }
            if(isHappy) {
                System.out.println("1");
            }
            else {
                System.out.println("0");
            }
            list.clear();
        }
    }
}
