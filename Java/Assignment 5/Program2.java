/*
 * Author: Brandon Hough
 * 
 * Assignment 5: Java Collections
 * 
 * Purpose: Put the words typed via the scanner into a HashMap. The values will be the number of times a word occurs, 
 * 			while the key will be the word itself. The word that occurs the most will be printed out once a blank
 * 			line has been entered. 
 */ 

import java.util.HashMap;
import java.util.Scanner;
import java.util.Collections;

public class Program2
{
	public static void main(String[] args)
	{
		HashMap<String, Integer> wordFrequency = new HashMap<>(); //create a HashMap with keys of Strings and values of Integers
		
		boolean keepgoing = true; //boolean to keep the loop going until a blank line is entered
		
		while(keepgoing)
		{
			Scanner input = new Scanner(System.in); //creates a scanner named input
			String line = input.nextLine().toLowerCase(); //used the toLowerCase() to make sure every character 
														  //was lower case before processed
			String[] arr = line.split(" ");
			
			
			if (arr[0].equals("")) //ends program when a blank input is entered
			{
				keepgoing = false;
			}
			
			else
			{
				for(int i = 0; i < arr.length; i++) //for loop that goes through the array of words
				{
					if(!wordFrequency.containsKey(arr[i])) //if the word has not been seen yet
					{
						wordFrequency.put(arr[i],1); //add that word to the HashMap with a value of 1
					}
					else //else the word has been seen before
					{
						wordFrequency.put(arr[i], wordFrequency.get(arr[i])+1); //so update the value of that word by one
					}
				}
			}
		}
		
		int maxFreqWordCount = 0;
		String maxFreqWord = "";
		for (HashMap.Entry<String, Integer> entry : wordFrequency.entrySet()) //for each that iterates through the HashMap
		{
		    if(maxFreqWordCount < entry.getValue()) //if we find a count of a word greater then what we already have
		    {
		    	maxFreqWordCount = entry.getValue(); //update the maxFreqCount to the new highest value in the HashMap
		    	maxFreqWord = entry.getKey(); //update the maxFreqWord to the word that is now the most frequent
		    }
		}
		
		//prints out the most common word and how many times that word was typed via the scanner
		System.out.println("The most common word is " + maxFreqWord + " which appeared " + maxFreqWordCount + " times" ); 
	}
}