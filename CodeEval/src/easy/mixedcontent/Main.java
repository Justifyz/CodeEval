package easy.mixedcontent;
import java.io.*;
import java.util.ArrayList;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
           String[] input = line.trim().split(",");
        	ArrayList<Integer> digitList = new ArrayList<Integer>();
        	ArrayList<String> wordList = new ArrayList<String>();
        	for(int i = 0; i < input.length; i++) {

        		try {
        			int piece = Integer.parseInt(input[i]);
        			digitList.add(piece);
        		}
        		catch(Exception e) {
        			wordList.add(input[i]);
        		}
        	}
        	StringBuilder sb = new StringBuilder();
        	for(int i = 0; i < wordList.size(); i++) {
        		sb.append(wordList.get(i)+",");
        	}
        	if(sb.length()!=0) {
        		sb.replace(sb.length()-1, sb.length(),"|");
        	}
        	for(int i = 0; i < digitList.size(); i++) {
        		sb.append(digitList.get(i)+",");
        	}
        	sb.replace(sb.length()-1, sb.length(),"");
        	System.out.println(sb.toString());
        }
    }
}
