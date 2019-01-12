/*
 * Author: Brandon Hough and Craig Tanis
 * 
 * Assignment 3
 * 
 * Purpose: Using a Singly Linked List to implement the methods: T get(int index), 
 * void set(int index, T value), void add(T value), void add(int index, T value),
 * void remove(int index), and boolean contains(T value). What these methods do exactly
 * will be in the comments above the method. 
 */

import java.util.Iterator;

	public class SList<T> implements Iterable<T>
	{
		private class Node
		{
			T value;
			Node next;
		}

		private Node head;

		public void addFirst(T v)

		{
			Node n = new Node();
			n.value = v;
			n.next = head;
			head = n;
		}

		public void removeFirst()
		{
			head = head.next;
		}

		public int size()

		{
			int count = 0;
			Node curs = head;
			while (curs != null)
			{
				count++;
				curs = curs.next;
			}

			return count;
		}

		
		//returns the value in the list at the specified index. 
		//throw a java.lang.RuntimeException if index is invalid.
		public T get(int index)
		{	
			if (index < 0 || index >= size()) //if index is less than 0 or is larger than the size
			{
				throw new RuntimeException("Index Is Out Of Bounds!"); //throw an exception
			}
			else
			{
				Node temp = head;
				
				for (int i = 0; i < index; i++) //iterate over the nodes till you reach the given index
				{
					temp = temp.next;
				}
				return temp.value; //once you reach the given index, the loop will end and the value 
			}					  //at the node is returned
		}


		//changes the list item at position index to value. 
		//throw a java.lang.RuntimeException if index is invalid
		public void set(int index, T value)
		{
			if (index < 0 || index >= size()) //if index is less than 0 or is larger than the size
			{
				throw new RuntimeException("Index Is Out Of Bounds!"); //throw an exception
			}
			else
			{
				Node temp = head;
				
				for (int i = 0; i < index; i++) //iterate over the nodes till you reach the given index
				{
					temp = temp.next;
				}
				temp.value = value; //once you reach the given index, the loop will end and the value 
			}						//at that index will be replaced with the given value.
		}

		//inserts value into the list at the end
		public void add(T value)
		{
			Node n = new Node(); //create a new node with value given and next equal to null (since we are adding
			n.value = value; 	//to the end of the list
			n.next = null;

			//if there are no nodes yet, the head points to null
			if(head == null)
			{
				head = n; //make the head point to the newly created node
			}
			else
			{
				Node temp = head; 
				
				while(temp.next != null) //iterate over the nodes till you find a node that has
										 //a next value that is null
				{
					temp = temp.next; //go to the next node
				}
				temp.next = n; //when that node is found, the next of the last node visited
			}					//will point to the node n created in the beginning of the method
		}

		//inserts value at position index. throw a java.lang.RuntimeException 
		//if index is invalid
		public void add(int index, T value)
		{
			if(index < 0) //must be an index greater than 0 or the index is invalid
			{
				throw new RuntimeException("Index Is Out Of Bounds!"); //throw an exception
			}
			
			if(index == 0) //if the index is 0
			{
				Node n = new Node();
				n.value = value;
				n.next = head;
				head = n;
			}
			else //we have a valid index and it is not being add to the beginning of the list
			{
				Node prev = head;
				
				int count = 1;
				while(count <= index-1) //iterate till we get to the previous node of the one we
				{						//are going to add
					prev = prev.next;
					count++;
				}
				
				Node addedNode = new Node(); //create a new node called addedNode
				addedNode.next = prev.next; //set the reference to after the prev
				addedNode.value = value; //set the value given to the node
				prev.next = addedNode; //set the reference from the prev to the new addedNode
			}
			
		}

		//remove the item in the list at position index. throw a
		//java.lang.RuntimeException if index is invalid
		public void remove(int index)
		{
		if (index < 0 || index >= size()) //if index is less than 0 or is larger than the size
		{
			throw new RuntimeException("Index Is Out Of Bounds!"); //throw an exception
		}
		else if(index == 0) //since we are removing the first index, just call the removeFirst() method
		{
			removeFirst();
		}
					
		else 
		{
				Node prev = head;
						
				int count = 1;
				while(count <= index-1) //iterate till we get to the previous node of the one we
				{						//are going to remove
					prev = prev.next;
					count++;
				}
						
				Node deletedNode = prev.next; //store the node we are going into deletedNode
				prev.next = deletedNode.next; //changes reference of previous node to the node after the deletedNode
				deletedNode.next = null; //sets the deletedNode reference to null
			}
		}	

		//returns true if the list contains value. returns false otherwise
		public boolean contains(T value)
		{
			Node curs = head;
			
			while(curs != null) //iterate over the nodes till you reach the end, when the next value is equal to null
			{
				if(curs.value.equals(value)) //if the value in the node is equal to the value given
				{
					return true; //return true that the List contains that value
				}
					curs = curs.next; //advance to the next node in the List
			}
			return false; //otherwise return false that the List does not contain that value
		}


		private class SLIterator implements Iterator<T>
		{
			private Node n;
			
			public SLIterator()
			{
				n = null;
			}

			public boolean hasNext()
			{
				if (n == null)

				{

					return head != null;
				}
				else
				{
					return n.next != null;
				}
			}
			
			public T next()
			{
				if (n == null)
				{
					n = head;
				}
				else
				{
					n = n.next;
				}
				return n.value;
			}
		}

		public Iterator<T> iterator()
		{
			return new SLIterator();
		}
}