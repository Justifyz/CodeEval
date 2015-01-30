package easy.jsonmenuids;
import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File("input.txt");
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
        	line = line.trim();
        	Pattern pattern = Pattern.compile("\"id\": (\\d+), \"label\"");
        	int sum = 0;
        	if(line.length()==0) {
        		continue;
        	}
        	Matcher matcher = pattern.matcher(line);
        	while(matcher.find()) {
        		sum += Integer.parseInt(matcher.group(1));
        	}
        	System.out.println(sum);
        }
    }
}
