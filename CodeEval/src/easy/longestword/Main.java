package easy.longestword;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            String[] words = line.trim().split(" ");
            int max = 0;
            String biggestWord = "";
            for(int i = 0; i < words.length; i++) {
                if(words[i].length() > max) {
                    max = words[i].length();
                    biggestWord = words[i];
                }
            }
            System.out.println(biggestWord);
        }
    }
}
