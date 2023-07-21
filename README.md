# GroupsOnGraphs

This repository contains some julia code for computationally finding graph properties about solubility graphs of finite groups. 

- The GAP folder contains the file (SolubilizerAnalysis.g) which can be used to generate the adjacency matrices. (A few syntax warnings but it's functional).
- The Hamiltonians folder contains a txt file (hamiltonians.txt) that shows some of the paths we found for each adjacency matrix. The adjacency matrices are contained in the AdjMats subfolder. Lastly, hamiltonian_search.jl searches for the Hamiltonian cycles.
- The coloring folder contains color.jl which uses a greedy algorithm to try to find valid graph colorings, also contains a copy of the AdjMats folder.

Paper in preparation. Feel free to email for any questions!

Credit Jake Chuharski, Vismay Sharan, Zach Slonim
