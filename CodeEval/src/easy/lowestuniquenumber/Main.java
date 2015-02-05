package easy.lowestuniquenumber;
import java.io.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        Map<Integer,Integer> map;
        while ((line = buffer.readLine()) != null) {
        	map = new HashMap<Integer,Integer>();
        	String[] input = line.trim().split("\\s++");
        	int[] intArray = new int[input.length];
        	for(int i = 0; i < input.length; i++) {
        		int number = Integer.parseInt(input[i]);
        		intArray[i] = number;
        		if(map.containsKey(number)) {
        			map.put(number, map.get(number)+1);
        		}
        		else {
        			map.put(number, 1);
        		}
        	}
        	
        	Arrays.sort(intArray);
        	int lowestUnique = 0;
        	for(int i = 0; i < intArray.length; i++) {
        		int number = intArray[i];
        		if(map.get(number) == 1) {
        			lowestUnique = number;
        			break;
        		}
        	}
        	
        	if(lowestUnique == 0) {
        		System.out.println(0);
        	}
        	else {
        		String n = String.valueOf(lowestUnique);
        		for(int i = 0; i < input.length; i++) {
        			if(input[i].equals(n)) {
        				System.out.println(i+1);
        			}
        		}
        	}
        	
        }       	
    }
}
