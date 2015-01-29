package easy.wordtodigit;
import java.io.*;
import java.util.HashMap;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        HashMap<String,Integer> map = new HashMap<String,Integer>();
        map.put("zero",0);
        map.put("one", 1);
        map.put("two",2);
        map.put("three",3);
        map.put("four",4);
        map.put("five", 5);
        map.put("six", 6);
        map.put("seven",7);
        map.put("eight",8);
        map.put("nine",9);
        map.put("ten",10);
        while((line = buffer.readLine()) != null) {
        	String[] input = line.trim().split(";");
        	StringBuilder sb = new StringBuilder();
        	for(int i = 0; i < input.length; i++) {
        		sb.append(map.get(input[i]));
        	}
        	System.out.println(sb.toString());
        }        
    }
}
