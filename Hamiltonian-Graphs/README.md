
For the computational approach to Hamiltonian cycles, we use GAP to generate the adjacency matrix for $\Delta_S(G)$ and then use Julia to find a Hamiltonian cycle. We use a greedy random-search algorithm which picks a random starting point and then at each step picks randomly among the neighbor with the least number of connections to the remaining vertices of the graph that we need to reach. The output we get is a list of indices representing the elements in $G$ in the order of the Hamiltonian cycle.

For instance, with $G=A_5,$ we use the GAP function List(G) and remove the first element which is the identity to get a list of $59$ elements in some preset order. Then, the following array gives a Hamiltonian cycle where each number is the index of the corresponding element.

[35, 23, 57, 29, 46, 21, 34, 43, 27, 56, 8, 33, 39, 17, 51, 54, 18, 55, 49, 30, 22, 7, 44, 13, 5, 10, 20, 40, 2, 1, 4, 3, 11, 41, 45, 15, 48, 31, 14, 52, 58, 37, 25, 42, 53, 9, 16, 32, 19, 6, 36, 59, 28, 26, 24, 38, 47, 12, 50, 35] 

In other words, the $35$th and $23$rd elements generate a solvable subgroup of $A_5$, as do the $23$rd and $57$th elements and so on. 
