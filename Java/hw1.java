/*
 * Author: Brandon Hough
 * 
 * Assignment 1
 * 
 * Purpose: Write a simple program showing that a for loop that adds up
 * 2 x N numbers will take twice as long as one that adds up N numbers,
 * for large enough values of N
 * 
 * Note: I was unable to use the value of 800000000 for N without getting
 * an error code of "java.lang.OutOfMemoryError: Java heap space". So I used 
 * the following values: 700000000, 350000000, 175000000 and 87500000.
 * 
 * Output to Console:
 * 87500000 took 60.513278 ms
 * 175000000 took 124.01213 ms
 * 350000000 took 210.908579 ms
 * 700000000 took 438.839643 ms
 */

public class hw1
{
	public static void main(String[] args) 
	{
		long N = 87500000; //initialize N as the value 87500000
		long sum = 0; //initialize sum as a long
		
		while(N<=700000000 && N>=87500000) //this while loop will be run 4 times, increment of N*2 is used at the end to ensure so
		{
			int[] anArray; //initialize an array called anArray
			anArray = new int[(int) (N-1)]; //set the array length to N-1 values
			
			final double startTime = System.nanoTime(); //start the timer of for loop
			
			//for loop that goes from 0 to N-1, adding each value of i into an array,
			//then keeping a sum of all the values put into the array
			
			for (int i = 0; i < N-1; i++) 
			{
				anArray[i] = i;
				sum = sum + anArray[i];
			}
			
			final double endTime = System.nanoTime(); //end the timer of for loop
			
			System.out.println(N + " took " + ((endTime - startTime)/1000000) + " ms"); //displays time of for loop in ms
			
			N = N*2; //increment N to double the number of values
		}
	}
}