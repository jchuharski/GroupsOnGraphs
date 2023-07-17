# GroupsOnGraphs

This repository contains some julia code for computationally finding graph properties about solubility graphs of finite groups. 

- The GAP folder contains the file that generates the adjacency matrices.
- The Hamiltonians folder contains a txt file that shows some of the paths we found for each adjacency matrix in the similarly contained AdjMats folder along with Hamiltonian_search.jl which searches for the Hamiltonian cycles.
- The coloring folder contains color.jl which uses a greedy algorithm to try to find valid graph colorings, also contains a copy of the AdjMats folder and contains a script for running color.jl on MIT supercloud.

Paper in preparation. Feel free to email for any questions!
