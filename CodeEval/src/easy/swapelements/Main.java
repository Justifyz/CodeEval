package easy.swapelements;
import java.io.*;
import java.util.ArrayList;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            ArrayList<String> arrList = new ArrayList<String>();
        	String[] input = line.trim().split(":");
        	String[] list = input[0].trim().split("\\s++");
        	String[] positions = input[1].trim().split(",");
        	for(int i = 0; i < positions.length; i++) {
        		String[] temp = positions[i].trim().split("-");
        		arrList.add(temp[0]);
        		arrList.add(temp[1]);
        	}
        	for(int i = 0 ; i < arrList.size(); i+=2) {
        		int position1 = Integer.parseInt(arrList.get(i));
        		int position2 = Integer.parseInt(arrList.get(i+1));
        		String temp = list[position1];
        		list[position1] = list[position2];
        		list[position2] = temp;
        	}
        	StringBuilder sb = new StringBuilder();
        	for(int i = 0; i < list.length; i++) {
        		sb.append(list[i]+" ");
        	}
        	System.out.println(sb.toString().trim());
        }
    }
}
