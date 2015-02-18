package moderate.suggestgroups;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Stack;
import java.util.TreeMap;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File("input.txt");
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line; 
        TreeMap<String,HashMap<ArrayList<String>,ArrayList<String>>> map = new TreeMap<String,HashMap<ArrayList<String>,ArrayList<String>>>();
        while ((line = buffer.readLine()) != null) {
        	String[] input = line.trim().split(":");
        	String name = input[0];
        	ArrayList<String> friends = new ArrayList<String>();
        	String[] friendsList = input[1].split(",");
        	for(int i = 0; i < friendsList.length; i++) {
        		friends.add(friendsList[i]);
        	}
        	ArrayList<String> groups = new ArrayList<String>();
        	String[] groupsList;
        	if(input.length < 3) {
        		groupsList = new String[0];
        	}
        	else {
        		groupsList = input[2].split(",");
        	}
        	for(int i = 0; i < groupsList.length; i++) {
        		groups.add(groupsList[i]);
        	}
        	HashMap<ArrayList<String>,ArrayList<String>> newMap = new HashMap<ArrayList<String>,ArrayList<String>>();
        	newMap.put(friends,groups);
        	map.put(name, newMap);
        }  
        for(Map.Entry<String,HashMap<ArrayList<String>,ArrayList<String>>> entry : map.entrySet()) {
        	StringBuilder sb = new StringBuilder();
        	String user = entry.getKey();
        	sb.append(user+":");
        	HashMap<ArrayList<String>,ArrayList<String>> value = entry.getValue();
        	int numOfFriends = 0;
        	ArrayList<String> usersFriends = null;
        	ArrayList<String> usersGroups = null;
        	TreeMap<String,Integer> groupActivity = new TreeMap<String,Integer>();
        	for(Map.Entry<ArrayList<String>,ArrayList<String>> newEntry: value.entrySet()) {
        		numOfFriends = newEntry.getKey().size();
        		usersFriends = newEntry.getKey();
        		usersGroups = newEntry.getValue();
        	}
        	for(int i = 0; i < usersFriends.size(); i++) {
        		String friend = usersFriends.get(i);
        		HashMap<ArrayList<String>,ArrayList<String>> friendInfo = map.get(friend);
        		for(Map.Entry<ArrayList<String>,ArrayList<String>> friendEntry: friendInfo.entrySet()) {
        			ArrayList<String> friendsGroups = friendEntry.getValue();
        			for(int j = 0; j < friendsGroups.size(); j++) {
        				String activity = friendsGroups.get(j);
        				if(groupActivity.containsKey(activity)) {
        					groupActivity.put(activity, groupActivity.get(activity)+1);
        				}
        				else {
        					groupActivity.put(activity, 1);
        				}
        			}
        		}
        	}
        	boolean hasSuggestions = false;
        	for(Map.Entry<String,Integer> groupParticipants : groupActivity.entrySet()) {
        		String activity = groupParticipants.getKey();
        		int numOfParticipants = groupParticipants.getValue();
        		int halfOfFriends = (int) Math.ceil(numOfFriends/2.0);
        		if(numOfParticipants >= halfOfFriends && !usersGroups.contains(activity)) {
        			sb.append(activity+",");
        			hasSuggestions = true;
        		}
        	}
        	if(hasSuggestions) {
        		sb.delete(sb.length()-1, sb.length());
        		System.out.println(sb.toString());
        	}
        }        
    }
}




