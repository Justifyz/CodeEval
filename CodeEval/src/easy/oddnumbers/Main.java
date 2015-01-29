package easy.oddnumbers;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
       for(int i = 1; i <= 99; i++) {
           if(i%2 == 1) {
               System.out.println(i);
           }
       }
    }
}