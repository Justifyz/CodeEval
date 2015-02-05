package easy.bigdigits;
import java.io.*;
import java.util.ArrayList;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        String[][] bigDigits = 
        { 
          {"-**-",
           "*--*",
           "*--*",
           "*--*",
           "-**-",
           "----"},
          {"--*-",
           "-**-",
           "--*-",
           "--*-",
           "-***",
           "----"},
          {"***-",
           "---*",
           "-**-",
           "*---",
           "****",
           "----"},
          {"***-",
           "---*",
           "-**-",
           "---*",
           "***-",
           "----"},
          {"-*--",
           "*--*",
           "****",
           "---*",
           "---*",
           "----"},
          {"****",
           "*---",
           "***-",
           "---*",
           "***-",
           "----"},
          {"-**-",
           "*---",
           "***-",
           "*--*",
           "-**-",
           "----"},
          {"****",
           "---*",
           "--*-",
           "-*--",
           "-*--",
           "----"},
          {"-**-",
           "*--*",
           "-**-",
           "*--*",
           "-**-",
           "----"},
          {"-**-",
           "*--*",
           "-***",
           "---*",
           "-**-",
           "----"}
        };
        while ((line = buffer.readLine()) != null) {
        	char[] input = line.trim().toCharArray();
        	ArrayList<Integer> list = new ArrayList<Integer>();
        	for(int i = 0; i < input.length; i++) {
        		if(Character.isDigit(input[i])) {
        			list.add(Character.getNumericValue(input[i]));
        		}
        	}
        	StringBuilder sb = new StringBuilder();
        	for(int i = 0; i < 6; i++) {
        		for(int j = 0; j < list.size(); j++) {
        			sb.append(bigDigits[list.get(j)][i]+"-");
        		}
        		sb.append("\n");
        	}
        	System.out.print(sb.toString());
        }
    }
}
