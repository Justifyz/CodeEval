package easy.selfdescribingnumbers;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
          	boolean isSelfDescribing = true;
        	 String s = line;
             for(int i = 0; i < s.length(); i++){
                 String s0 = s.charAt(i) + "";
                 int b = Integer.parseInt(s0); 
                 int count = 0;
                 for(int j = 0; j < s.length(); j++){
                     int temp = Integer.parseInt(s.charAt(j) + "");
                     if(temp == i){
                         count++;
                     }
                     if (count > b) isSelfDescribing = false;
                 }
                 if(count != b) isSelfDescribing = false;
             }
             System.out.println(isSelfDescribing?"1":"0");
        }
    }
}
