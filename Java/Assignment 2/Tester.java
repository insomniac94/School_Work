/*
 * Author: Brandon Hough
 * 
 * Assignment 3
 * 
 * Purpose: To Test the SList.Java class. Expected and Actual Output
 * results will be in the console when the program is ran.
 */

public class Tester
{
    public static void main(String[] args) 
    {
    	SList<Integer> lst = new SList<>();

        for (int i=0; i<20; i++)
        { 
            lst.addFirst(i);
        }
        
        
        System.out.print("Original List Expceted: ");
        for(int i = 19; i>=0; i--)
        {
        	System.out.print(i + " ");
        }
        
        System.out.println("");
        System.out.print("Original List Actual: ");
        for (Integer val : lst)
        {
            
        	System.out.print(val + " ");
        }
        
        System.out.println("");
        System.out.println("");
        System.out.print("Returned Values At the ith Index Expected: ");
        for(int i = 0; i<20; i++)
        {
        	System.out.print(i + " ");
        }
        
        System.out.println("");
        System.out.print("Returned Values At the ith Index Actual: ");
        
        for (Integer val : lst)
        {
            
        	System.out.print(lst.get(val) + " ");
        }
        

        System.out.println("");
        System.out.println("");
        System.out.print("Change Values at Certain Index Expected: 42 18 17 16 15 14 13 12 11 7 9 8 7 6 5 4 3 2 153 0");
        System.out.println("");
        
        lst.set(0, 42);
        lst.set(18, 153);
        lst.set(9, 7);
        System.out.print("Change Values at Certain Index Actual: ");
        
        for (Integer val : lst)
        {
        	System.out.print(val + " ");
        }
        

        System.out.println("");
        System.out.println("");
        System.out.println("Added Values Expected: 42 18 17 16 15 14 13 12 11 7 9 8 7 6 5 4 3 2 153 0 20 21 22 23 24");
        
        for(int i = 20; i<25; i++)
        {
        	lst.add(i);
        }
        
        System.out.print("Added Values Actual: ");
        for (Integer val : lst)
        {
        	System.out.print(val + " ");
        }
        
        lst.add(15,420);
        
        System.out.println("");
        System.out.println("");
        System.out.println("Added Values Expected: 42 18 17 16 15 14 13 12 11 7 9 8 7 6 5 420 3 2 153 0 20 21 22 23 24");
        
        System.out.print("Added Values Actual: ");
        for (Integer val : lst)
        {
        	System.out.print(val + " ");
        }
        
        for(int i = 3; i<15; i++)
        {
        	lst.remove(i);
        }
        
        System.out.println("");
        System.out.println("");
        
        System.out.println("Added Values Expected: 42 18 17 15 13 11 9 7 5 4 2 0 21 23 ");
        
        System.out.print("Removing Values Actual: ");
        for (Integer val : lst)
        {
        	System.out.print(val + " ");
        }
        
        System.out.println("");
        System.out.println("");
        
        System.out.println("Contains Expected: true");
        System.out.println("Contains Actual: " + lst.contains(21));
        
        System.out.println("");
        System.out.println("Contains Expected: false");
        System.out.println("Contains Actual: " + lst.contains(45));
        
    }  
   
}