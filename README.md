# reverse-cuthill-mckee
Combinatorial optimization : Reverse Cuthill Mckee ordering algorithm (RCM)


## RCM algorithm 

Here is a Matlab code for the Reverse Cuthill Mckee ordering algorithm (RCM). 

RCM is an algorithm to permute a sparse matrix that has a symmetric sparsity pattern into a band matrix form with a small bandwidth. 
In practice this generally results in less fill-in than the CM ordering when Gaussian elimination is applied.

It starts with a peripheral node and then generates levels until all nodes are exhausted. These nodes are listed in increasing degree. This last detail is the only difference with the breadth-first search algorithm.

## Context
The Cuthill - McKee algorithm is one of the most important reordering techniques commonly used. This algorithm is a variant of the Breadth First Search algorithm. The latter is a reference algorithm created in n of the 1950s by E.F.Moore to scan a graph iteratively, using one the. The Cuthill-Mckee algorithm is based on the contribution of Elizabeth Cuthill and J. McKee in 1969. Its main objective is to reduce the bandwidth (i.e. the distance between two adjacent vertices) of a hollow symmetric matrix by renumbering the vertices of the associated graph.

## Inputs & outputs

```
perm : the output permutation vector
A    : the initial matrix
```

