package easy.setintersection;
import java.io.*;
import java.util.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            String[] lists = line.trim().split(";");
            String[] list1 = lists[0].split(",");
            String[] list2 = lists[1].split(",");
            ArrayList<String> arrList1 = new ArrayList<String>(Arrays.asList(list1));
            ArrayList<String> arrList2 = new ArrayList<String>(Arrays.asList(list2));
            ArrayList<String> solution = new ArrayList<String>();
            for(int i = 0; i < arrList1.size(); i++) {
                String num = arrList1.get(i);
                if(arrList2.contains(num)) {
                    solution.add(num);
                }
            }
            for(int i = 0; i < solution.size(); i++) {
                System.out.print(solution.get(i));
                if(i < solution.size()-1) {
                    System.out.print(",");
                }
            }
            System.out.println();
        }
    }
}