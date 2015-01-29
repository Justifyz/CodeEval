package easy.calculatedistance;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            String[] input = line.trim().split("\\) \\(");
        	input[0] = input[0].replaceAll("\\(", "");
        	input[0] = input[0].replaceAll("\\)", "");
        	input[1] = input[1].replaceAll("\\(", "");
        	input[1] = input[1].replaceAll("\\)", "");
        	String[] point1 = input[0].split(",");
        	String[] point2 = input[1].split(",");
        	int x1 = Integer.parseInt(point1[0].trim());
        	int y1 = Integer.parseInt(point1[1].trim());
        	int x2 = Integer.parseInt(point2[0].trim());
        	int y2 = Integer.parseInt(point2[1].trim());
        	int distance = (int)Math.sqrt(Math.pow(x2-x1, 2) + Math.pow(y2-y1, 2));
        	System.out.println(distance);
        }
    }
}
