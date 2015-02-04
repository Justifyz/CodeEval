package easy.racingchars;
import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
        char[][] raceTrack = new char[50][12];
        int count = 0;
        while ((line = buffer.readLine()) != null) {
        	raceTrack[count] = line.trim().toCharArray();
        	count++;
        }
        int prevLoc, checkPointLoc, gateLoc;
        prevLoc = checkPointLoc = gateLoc = -1;
    	boolean checkPointFound;
        for(int row = 0; row < 50; row++) {
        	checkPointFound = false;
        	for(int col = 0; col < 12; col++) {
        		if(raceTrack[row][col] == 'C') {
        			checkPointLoc = col;
        			checkPointFound = true;
        		}
        		else if(raceTrack[row][col] == '_') {
        			gateLoc = col;
        		}
        	}
        	// First row is exception since you can only go straight
        	if(row == 0) {
        		// first check if checkpoint was found
        		if(checkPointFound) {
        			raceTrack[row][checkPointLoc] = '|';
        			prevLoc = checkPointLoc;
        		}
        		else {
        			// only gate is available
        			raceTrack[row][gateLoc] = '|';
        			prevLoc = gateLoc;
        		}
        	}
        	else {
        		if(checkPointFound) {
        			if(prevLoc < checkPointLoc) {
        				raceTrack[row][checkPointLoc] = '\\';
        			}
        			else if(prevLoc > checkPointLoc) {
        				raceTrack[row][checkPointLoc] = '/';
        			}
        			else {
        				raceTrack[row][checkPointLoc] = '|';
        			}
        			prevLoc = checkPointLoc;
        		}
        		else {
        			if(prevLoc < gateLoc) {
        				raceTrack[row][gateLoc] = '\\';
        			}
        			else if(prevLoc > gateLoc) {
        				raceTrack[row][gateLoc] = '/';
        			}
        			else {
        				raceTrack[row][gateLoc] = '|';
        			}
        			prevLoc = gateLoc;
        		}
        	}
        	
        }
        for(int row = 0; row < 50; row++) {
        	for(int col = 0; col < 12; col++) {
        		System.out.print(raceTrack[row][col]);
        	}
        	System.out.println();
        }
    }
}