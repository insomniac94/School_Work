
//testing the class Graph.java
import java.util.Arrays;

public class tester
{
	public  static  void  main(String [] args)
		{
		Graph <String > g = new Graph <>();
		
		g.addEdge("A", "C");
		g.addEdge("B", "C");
		g.addEdge("A", "B");
		
		System.out.println("Test  results: " + g.testPath(Arrays.asList("A", "B", "C")));
		System.out.println("Test  results: " + g.testPath(Arrays.asList("B", "C", "A")));
		g.addEdge("C", "A");
		System.out.println("Test  results: " + g.testPath(Arrays.asList("B", "C", "A")));
		
		try
		{
			g.testPath(Arrays.asList("Z"));
		}
		
		catch (Exception e)
		{
			System.out.println("Graph  threw  an  exception (I expected  that!)");
			e.printStackTrace ();
		}
	}
}
