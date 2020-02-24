# Future Work 1: Check for Forests before starting
clear all
clc
###################################################
#     Step 0: from Grid to Graph
###################################################
load maps
map = map3
global g

g = populate_graph_from_ogrid(map);
disp("Number of obstacles")
disp(g.obstacles)
disp(g.nodes{2})

###################################################
#     Step 2: Naive approach - DFS
###################################################
clc
disp("Testing simple maps")
map = [ 0, 0, 1 , 0;
          0, 0, 1 , 0;
          0, 0, 0 , 2];
g = populate_graph_from_ogrid(map);

disp("Perform a Depth First Search - DFS")

# Init node whishlist
global cells_to_visit
global visited
cells_to_visit = {};
visited = {};
for i=1:size(g.nodes,2)
  cells_to_visit{i} = g.nodes{i};
  visited{i} = false;
endfor

dfs(g.start.id)
disp(g.id_table)

# DFS does not provide a valid path
# Consecutive nodes in the path should be adjacent nodes

###################################################
#     Step 3: Inspect the parcour
###################################################

# Reset path 
path = {}; 
cells_to_visit = {};
visited = {};
for i=1:size(g.nodes,2)
  cells_to_visit{i} = g.nodes{i};
  visited{i} = false;
endfor

cost_fcn = 0;
k1 = 1;
k2 = 0;

# Search graph 
path = search(g);

###################################################
#     Step 4: What do we have so far?
###################################################

# A "sub-optimal" coverage path planning algorithm
# Let's see the results obtained so far
clc
disp(map)

disp("Remaining Cells to Visit:")
for i=1:size(cells_to_visit,2)
  if ~isempty(cells_to_visit{i})
    disp(cells_to_visit{i}.id)
  endif
endfor

disp("Path")
ids_path = zeros(1,size(path,2));
for i=1:size(path,2)
  disp(path{i}.id)
  ids_path(1,i) = path{i}.id;
  #disp(path{i}.x);
  #disp(path{i}.y);
endfor 

disp("Cost function") 
cost_fcn = k1*size(path,2) #+ k2*phase 
disp(cost_fcn)
disp(g.id_table)

disp("Number of cells")
disp(rows(map)*columns(map))

disp("Saving data")
csvwrite("current_map.csv",map);
csvwrite("map_id.csv",g.id_table);
csvwrite("path.csv",ids_path);

###################################################
#     Step 6: Considering test maps
###################################################
map = map3
g = {}
g = populate_graph_from_ogrid(map);

# Reset path
path = {}; 
cells_to_visit = {};
visited = {};
for i=1:size(g.nodes,2)
  cells_to_visit{i} = g.nodes{i};
  visited{i} = false;
endfor

# Compute path
path = search(g);


# Save data
csvwrite("current_map.csv",map);
csvwrite("map_id.csv",g.id_table);

ids_path = zeros(1,size(path,2));
for i=1:size(path,2)
  disp(path{i}.id)
  ids_path(1,i) = path{i}.id;
endfor 
csvwrite("path.csv",ids_path);

###################################################
#     Step 6: Considering tricky parcours
###################################################

problematic_map_1 = [ 1, 0, 1 ,          1, 1 ,1 ,1 ,1 ,        1, 1, 1, 1, 1          , 1, 1, 1, 1, 1, 1   ;
                      1, 0, 1 ,          1, 1 ,1 ,1 ,1 ,        1, 1, 1, 1, 1          , 1, 1, 1, 1, 1, 1   ;
                      0, 0, 0 ,          0 ,0 ,0 , 0, 0,        0, 0, 0, 0, 0         , 0 ,0 ,0 , 0, 0, 0   ;
                      1, 0, 1 ,          1, 1 ,1 ,1 ,1 ,        1, 1, 1, 1, 1          , 1, 1, 1, 1, 1, 1   ;
                      1, 2, 1 ,          1, 1 ,1 ,1 ,1 ,        1, 1, 1, 1, 1         , 1, 1, 1, 1, 1, 1  ];


problematic_map_2 = [ 0, 0, 0 , 0;
                  0, 0, 0 , 0;
                  0, 1, 1 , 1;
                  0, 0, 0 , 0;
                  0, 0, 0 , 2];
                  
map = problematic_map_1
g = {}
g = populate_graph_from_ogrid(map);

# Reset path
path = {}; 
cells_to_visit = {};
visited = {};
for i=1:size(g.nodes,2)
  cells_to_visit{i} = g.nodes{i};
  visited{i} = false;
endfor

# Compute path
path = search(g);


# Save data
csvwrite("current_map.csv",map);
csvwrite("map_id.csv",g.id_table);

ids_path = zeros(1,size(path,2));
for i=1:size(path,2)
  disp(path{i}.id)
  ids_path(1,i) = path{i}.id;
endfor 
csvwrite("path.csv",ids_path);            