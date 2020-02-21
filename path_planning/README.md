# Path planning Discovery

Collection of graph traversal approaches. Aim: Visiting each vertex in a graph. 

## What we are looking for

Given a NxM matrix representing an occupancy grid, in which free areas are marked with 0, obstacles with 1 and the starting point with 2, find a candidate trajectory that passes through all the cells while minimizing the number of steps.

## What we are expecting

We want a function that takes as argument an occupancy grid and returns a sequence of cells (with their corresponding coordinates) it goes through in order from the starting point.

Ideally, the code should include a simple visualisation to verify the results
