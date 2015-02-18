package moderate.stackimplementation;
import java.io.*;
import java.util.ArrayList;
import java.util.EmptyStackException;
public class Main {
	private static ArrayList<String> stack;
    public static void main (String[] args) throws IOException {
    	stack = new ArrayList<String>();
        File file = new File("input.txt");
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line; 
        while ((line = buffer.readLine()) != null) {
        	String[] input = line.trim().split("\\s++");
        	for(int i = 0; i < input.length; i++) {
        		push(input[i]);
        	}
        	int count = 1;
        	StringBuilder sb = new StringBuilder();
        	while(!stack.isEmpty()) {
        		String item = pop();
        		if(count%2==1) {
        			sb.append(item+" ");
        		}
        		count++;
        	}
        	System.out.println(sb.toString().trim());
        }
    }
    
    public static void push(String n) {
    	stack.add(0,n);
    }
    
    public static String pop() throws EmptyStackException {
    	if(stack.size() == 0) {
    		throw new EmptyStackException();
    	}
    	else {
    		String n = stack.get(0);
    		stack.remove(0);
    		return n;
    	}
    }
    
    public static boolean isEmpty() {
    	return stack.size() == 0;
    }
    
    
}




