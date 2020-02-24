# Coverage Path planning Problem

Determine an optimal path involving all points of a given area of interest, while avoiding sub-areas with specific characteristics (obstacles). In the literature, this problem is often referred to as Coverage Path Planning problem. CPP is known in the literature to be NP-hard.



## What we are looking for

Given a NxM matrix representing an occupancy grid, in which free areas are marked with 0, obstacles with 1 and the starting point with 2, find a candidate trajectory that passes through all the cells while minimizing the number of steps of the path.

## What we are expecting

We want a function that takes as argument an occupancy grid and returns a sequence of cells (with their corresponding coordinates) it goes through in order from the starting point.

Ideally, the code should include a simple visualisation to verify the results


## Literature

* A* Based Solution to the Coverage Path Planning Problem
Conference Paper (PDF Available) in Advances in Intelligent Systems and Computing, 2018, Iberian Robotics conference

* Coverage path planning software for autonomous robotic lawn mower using Dubins' curve
 2017 IEEE International Conference on Real-time Computing and Robotics (RCAR)

* The development of autonomous navigation and obstacle avoidance for a robotic mower using navigation machine vision technique
Biological and Environmental Engineering, The University of Tokyo.

* mCPP | multi Coverage Path Planning algorithm

  DARP algorithm divides the terrain into a number of equal areas each corresponding to a specific robot, so as to guarantee complete coverage, non-backtracking solution, minimum coverage path, while at the same time does not need any preparatory stage.

  Repo:     https://github.com/athakapo/DARP
  Link:     http://kapoutsis.info/?page_id=25
  Youtube:  https://www.youtube.com/watch?v=LrGfvma

* Algorithmic Foundations of Robotics V
How to get a path from a Minimum Spanning Tree. MST obtained using Prim or Kruskal alg - chapters about MST

### Other Links

* 3D maps of Glasgow Golf clubs 
https://www.williamwoodgc.co.uk/course-1.html
