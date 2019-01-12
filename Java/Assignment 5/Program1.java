/*
 * Author: Brandon Hough
 * 
 * Assignment 5: Java Collections
 * 
 * Purpose: Sort the words in a list of Strings by the amount of words in each String 
 * using a Tree Set.
 */ 

import java.util.TreeSet;
import java.util.Comparator;

public class Program1 
{
	static class WordCountComp implements Comparator<String>
	{
		@Override
		public int compare(String str1, String str2)
		{
			int str1wc = str1.split("\\s+").length;
			int str2wc = str2.split("\\s+").length;

			if (str1wc < str2wc) //if string 1 has less words then string 2
			{
				return -1; //put string 1 before string 2
			}
	        else if (str1wc > str2wc) //if string 2 has less words then string 1
	        {
	        	return 1; //put string 2 before string 1
	        }
	        else
	        {
	        	return str1.compareTo(str2); //else they have the same amount of words so the letters of each string are
	        }								//compared and whichever word comes first alphabetically will appear first
	     }									//when printed
	   }
	
	public static void main(String[] args)
	{
		TreeSet<String> ts = new TreeSet<>(new WordCountComp());
		 
		ts.add("nike sucks");
		ts.add("computer science is vital");
		ts.add("xyz");
		ts.add("steak yes please");
		ts.add("apple");
		ts.add("xyz");
		ts.add("adidas rocks");
		ts.add("bats really eat bananas");
		ts.add("artichokes no thanks");
		
		for(String s : ts)
		{
			System.out.println(s);
		}
	 }
}
