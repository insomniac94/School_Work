/*
 * Author: Brandon Hough
 * 
 * Assignment 6: Adjacency Lists
 * 
 * Purpose: This program will add edges to a directed graph, then test if a path is valid.
 */

import java.util.Map;
import java.util.Set;
import java.util.List;
import java.util.HashMap;
import java.util.TreeSet;

public class Graph<T>
{
	private T start;
	private T end;
	
	public  Graph()
	{
		adjacency = new HashMap<>();
	}
	
	//this method adds the directed edge (start, end) to the graph. in the map adjacency, get
	//or create the Set associated with start, and add end to this Set.
	public  void addEdge(T start , T end)
	{
			this.start = start;
			this.end = end;
			
			HashMap<String,TreeSet<String>> graph = new HashMap<>();
			
			if(!graph.containsKey(start))
			{
				graph.put(start, end);
			}
			else
			{
				
			}
	}
	
	//this method should true if each consecutive pair of vertices in the list exists in the graph
	//and return false otherwise
	public  boolean testPath(List <T> vertexList)
	{
		return true;
	}
		
	private Map <T,Set <T>> adjacency;
}
