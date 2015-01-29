package easy.majorelement;
import java.io.*;
import java.util.HashMap;
import java.util.Map;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
           	HashMap<Integer,Integer> map = new HashMap<Integer,Integer>();
        	String[] input = line.trim().split(",");
        	for(int i = 0; i < input.length; i++) {
        		int num = Integer.parseInt(input[i]);
        		if(map.containsKey(num)) {
        			map.put(num,map.get(num)+1);
        		}
        		else {
        			map.put(num, 1);
        		}
        	}
        	String solution = "None";
        	for(Map.Entry<Integer, Integer> entry : map.entrySet()) {
        		int num = entry.getKey();
        		int occurence = entry.getValue();
        		if(occurence > input.length/2) {
        			solution = String.valueOf(num);
        		}
        	}
        	System.out.println(solution);
        }
    }
}
