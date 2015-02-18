package moderate.firstnonrepeatedcharacter;
import java.io.*;
import java.util.HashMap;
import java.util.Map;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File("input.txt");
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line; 
        while ((line = buffer.readLine()) != null) {
        	HashMap<Character,Integer> map = new HashMap<Character,Integer>();
        	char[] input = line.trim().toCharArray();
        	for(int i = 0; i < input.length; i++) {
        		char c = input[i];
        		if(map.containsKey(c)) {
        			map.put(c, map.get(c)+1);
        		}
        		else {
        			map.put(c, 1);
        		}
        	}
        	for(int i = 0; i < input.length; i++) {
        		char c = input[i];
        		int occurence = map.get(c);
        		if(occurence == 1) {
        			System.out.println(c);
        			break;
        		}
        	}
        }
    }
}




