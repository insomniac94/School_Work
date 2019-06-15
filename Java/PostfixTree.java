/*
 * Author: Brandon Hough
 * 
 * Assignment 4: Expresssion Trees
 * 
 * Purpose: For this assignment you will write a class that transforms a Postfix expression (interpreted as a
 * sequence of method calls) into an expression tree, and provide methods that process the tree in
 * different ways.
 */

import java.util.Stack;

public class PostfixTree
{
	private class Node
	{
		Node left, right;
		String value;
		double number;
		boolean isOperand;
	}

	Stack<Node> stack = new Stack<Node>(); //create a new stack that holds Nodes
	 
	//pushes a new Node to the stack that contains the double d as well as isOperand = true
	//that tells us this Node is Operand node
	public void pushNumber(double d)
	{
		Node n = new Node(); 
		n.number = d; 
		n.isOperand = true; 
		stack.push(n);
	}
		
	//pushes a new Node to the stack that contains the value of the addition operator ("+")
	//stored in value. As well at the last two numbers on the stack that are stored in left
	//and right children of this new Node.
	public void pushAdd()
	{
		Node n = new Node();
		n.value = "+";
		n.isOperand = false;
		n.right = stack.pop(); 
		n.left = stack.pop();
	
		stack.push(n);
	}
	
	//pushes a new Node to the stack that contains the value of the multiply operator ("*")
	//stored in value. As well at the last two numbers on the stack that are stored in left
	//and right children of this new Node.	
	public void pushMultiply()
	{
		Node n = new Node();
		n.value = "*";
		n.isOperand = false;
		n.right = stack.pop();
		n.left = stack.pop();
	
		stack.push(n);
	}
		
	//pushes a new Node to the stack that contains the value of the subtract operator ("-")
	//stored in value. As well at the last two numbers on the stack that are stored in left
	//and right children of this new Node.	
	public void pushSubtract()
	{	
		Node n = new Node();
		n.value = "-";
		n.isOperand = false;
		n.right = stack.pop();
		n.left = stack.pop();
	
		stack.push(n);
	}
		
	//pushes a new Node to the stack that contains the value of the divide operator ("/")
	//stored in value. As well at the last two numbers on the stack that are stored in left
	//and right children of this new Node.
	public void pushDivide()
	{
		Node n = new Node();
		n.value = "/";
		n.isOperand = false;
		n.right = stack.pop();
		n.left = stack.pop();
	
		stack.push(n);
	}
	
	/* Note:
	   When we have a complete postfix expression, the top of the stack will contain the whole tree.
	   If we have an invalid postfix expression the last binary tree added will be on the top 
	   of the stack, but it will not be the only node on the stack. Therefore this method with an 
	   invalid postfix will only calculate the last tree added to the stack. If only a number node 
	   is on top of the stack. That number will be printed out.
	 */
		
	//this method simply just stores the node at the top of the stack and recursively calls
	//the private methods findEvaluate on the Node n until you traverse the whole tree. The
	//finalAnswer is then returned to the console. 
	public double evaluate()
	{
		Node n = stack.peek();
		return(findEvaluate(n));
	}
	
	//this method returns the answer of the expression tree through post-order
	//depth first traversal of the tree
	private double findEvaluate(Node n)
	{
		double finalAnswer = 0; //double used to print out what the tree evaluates to
		
		if(n.isOperand) //base case, if we only have a number node on the top of the stack
		{
			return n.number; //return the number stored at n.number
		}
		else //recursive call
		{
			double deepestL = findEvaluate(n.left); //store the deepest left value we have not visited in L
			double deepestR = findEvaluate(n.right); //store the deepest right value we have not visited in R
			
			//switch case that checks the operator
			switch(n.value) 
			{
			case ("+"): //if we have an n.value has a "+" stored in it
				return finalAnswer = deepestL + deepestR; //then we add the deepestL to the deepestR
			
			case ("*"): //if we have an n.value has a "*" stored in it
				return finalAnswer = deepestL * deepestR; //then we multiply the deepestL to the deepestR
			
			case ("-"): //if we have an n.value has a "-" stored in it
				return finalAnswer = deepestL - deepestR; //then we subtract the deepestL to the deepestR
			
			case ("/"): //if we have an n.value has a "/" stored in it
				return finalAnswer = deepestL / deepestR; //then we divide the deepestL to the deepestR
			}
		}
		return finalAnswer; //returns the final answer
	}
				
	//this method simply just stores the node at the top of the stack and recursively calls
	//the private methods findInorder on the Node n.
	public String inorder()
	{	
		Node n = stack.peek();
		return(findInorder(n));
	}
	
	//this method uses recursive calls of itself to traverse the tree in a depth first,
	//or also known as in-order traversal. 
	private String findInorder(Node n)
	{
		String result = ""; //String used to print out the expression tree in heavily parenthesised infix form
		
		if(n.isOperand) //base case, if we only have a number node on the top of the stack
		{
			result = result + n.number; //return the number stored at n.number
		}
		else //recursive call that concatenates the node values and operates into a String result
		{
			result += "(" +  findInorder(n.left);
			result += " " + n.value + " ";		  
			result +=  findInorder(n.right) + ")";
		}
		return result; //final inOrder String is returned
	}

	//this method simply just stores the node at the top of the stack and recursively calls
	//the private methods findHeight on the Node n.
	public int height()
	{
		Node n = stack.peek();
		return(findHeight(n));
	}
	
	private int findHeight(Node n)
	{
		if(n.isOperand) //base case, if we only have a number node on the top of the stack
		{
			return 0; //return 0 since 
		}
		else //recursive call on itself that keeps a counter for the left and right
		{
			int leftSideCounter = findHeight(n.left);
			
			int rightSideCounter = findHeight(n.right);
			
			//if the left side counter is > right side counter
			if(leftSideCounter > rightSideCounter)
			{
				return leftSideCounter+1; //we will return the left side counter + 1
			}
			
			else
			{
				return rightSideCounter+1; //else the right side must be larger so we return
			}								//the right side counter + 1
		}
	}
}




