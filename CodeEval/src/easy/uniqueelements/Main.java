package easy.uniqueelements;
import java.io.*;
import java.util.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            String[] nums = line.trim().split(",");
            ArrayList<Integer> list = new ArrayList<Integer>();
            ArrayList<Integer> sorted = new ArrayList<Integer>();
            for(int i = 0; i < nums.length; i++) {
                int num = Integer.parseInt(nums[i]);
                if(!(list.contains(num))) {
                    list.add(num);
                    sorted.add(num);
                }
            }
            Integer[] solution = sorted.toArray(new Integer[sorted.size()]);
            for(int i = 0; i < solution.length; i++) {
                System.out.print(solution[i]);
                if(i < solution.length-1) {
                    System.out.print(",");
                }
            }
            System.out.println();
            list.clear();
        }
    }
}
