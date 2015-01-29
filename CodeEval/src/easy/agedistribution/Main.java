package easy.agedistribution;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        while ((line = buffer.readLine()) != null) {
            String[] input = line.trim().split("\\s++");
        	for(int i = 0; i < input.length; i++) {
        		int age = Integer.parseInt(input[i]);
        		if(age >= 0 && age <= 2) {
        			System.out.println("Still in Mama's arms");
        		}
        		else if(age == 3 || age == 4) {
        			System.out.println("Preschool Maniac");
        		}
        		else if(age >= 5 && age <= 11) {
        			System.out.println("Elementary school");
        		}
        		else if(age >= 12 && age <= 14) {
        			System.out.println("Middle school");
        		}
        		else if(age >= 15 && age <= 18) {
        			System.out.println("High school");
        		}
        		else if(age >= 19 && age <= 22) {
        			System.out.println("College");
        		}
        		else if(age >= 23 && age <= 65) {
        			System.out.println("Working for the man");
        		}
        		else if(age >= 66 && age <= 100) {
        			System.out.println("The Golden Years");
        		}
        	}
        }
    }
}