#include <iostream>
#include <list>
#include <stack>
#include <fstream>
std::ifstream infile("blog_adj_directed.txt");
// Storage for visited nodes
bool visited[ 10000000 ];

class Graph
{
  int V;    // No. of vertices
  bool directed;
  std::list<int> *adj;    // An array of adjacency lists
  
  // A recursive function to print DFS starting from v
  void DFSUtil(int v, bool visited[]);
public:
  // Constructor and Destructor
  Graph(int V, bool directed)
  {
	this->V = V;
	this->directed = directed;
	adj = new std::list<int>[V];
  }
  ~Graph() { delete [] adj; }
  
  // Method to add an edge
  void addEdge(int v, int w);
  
  // The main function that returns true if the graph is strongly
  // connected, otherwise false
  bool isCon();
  
  // Function that returns reverse (or transpose) of this graph
  Graph* getTranspose();
};

// A recursive function to print DFS starting from v
void Graph::DFSUtil(int v, bool visited[])
{
  // Mark the current node as visited and print it
  visited[v] = true;
  
  // Recur for all the vertices adjacent to this vertex
  
  std::list<int>::iterator i;
  for (i = adj[v].begin(); i != adj[v].end(); ++i)
	if (!visited[*i])
	  DFSUtil(*i, visited);
}

// Function that returns reverse (or transpose) of this graph
Graph* Graph::getTranspose()
{
  Graph* g = new Graph(V, directed);
  for (int v = 0; v < V; v++)
  {
	// Recur for all the vertices adjacent to this vertex
	std::list<int>::iterator i;
	for(i = adj[v].begin(); i != adj[v].end(); ++i)
	{
	  g->adj[*i].push_back(v);
	}
  }
  return g;
}

void Graph::addEdge(int v, int w)
{
  adj[v].push_back(w);
  
  if ( !directed) adj[w].push_back(v);
}

// The main function that returns true if graph is connected
bool Graph::isCon()
{
  // Step 1: Mark all the vertices as not visited (For first DFS)
  
  for (int i = 0; i < V; i++)
	visited[i] = false;
  
  // Step 2: Do DFS traversal starting from first vertex.
  DFSUtil(0, visited);
  
  // If DFS traversal doesn’t visit all vertices, then return false.
  for (int i = 0; i < V; i++)
	if (visited[i] == false)
	  return false;
  
  // Step 3: Create a reversed graph
  Graph* gr = getTranspose();
  
  // Step 4: Mark all the vertices as not visited (For second DFS)
  for(int i = 0; i < V; i++)
	visited[i] = false;
  
  // Step 5: Do DFS for reversed graph starting from first vertex.
  // Starting Vertex must be same starting point of first DFS
  gr->DFSUtil(0, visited);
  
  // If all vertices are not visited in second DFS, then
  // return false
  for (int i = 0; i < V; i++)
	if (visited[i] == false)
	  return false;
  
  return true;
}

// Driver program to test above functions
int main()
{
  // Example I: disconnected un-directed graph:
  //
  //     0      3
  //    / \    /
  //   1   2  4
  // nodes [3,4] disconnected from nodes [0,1,2]
  Graph g1( 5, false );
  g1.addEdge(0, 1);
  g1.addEdge(0, 2);
  g1.addEdge(3, 4);
  g1.isCon() ? std::cout << "Yes\n" :
  std::cout << "No\n";
  
  // Example II: connected (un-directed) graph:
  //
  // 3 <-> 2 <-> 1 <-> 0 <-> 4
  // All nodes can communicate with any other node
  Graph g3( 5, false );
  g3.addEdge(1, 0);
  g3.addEdge(4, 0);
  g3.addEdge(1, 2);
  g3.addEdge(2, 3);
  g3.isCon() ? std::cout << "Yes\n" :
  std::cout << "No\n";
  
  
  // Example III: connected (un-directed) graph
  //
  // 0 <-> 1 <-> 2 <-> 3
  // All nodes can communicate with any other node
  Graph g5( 4, false );
  g5.addEdge(0, 1);
  g5.addEdge(1, 2);
  g5.addEdge(2, 3);
  g5.isCon() ? std::cout << "Yes\n" :
  std::cout << "No\n";
  
  // Example IV: cora graph
  //
  Graph blog( 10312, false );
  int a,b;
  while (infile >> a >> b)
  {
	blog.addEdge(a, b);
  }
  blog.isCon() ? std::cout << "blog: Yes\n" :
  std::cout << "blog: No\n";
  return 0;
}
