clear
clc
###################################################
# Utility variables
###################################################
plotting = true

###################################################
# Path Planning
###################################################

load maps
map = [ 0, 0, 1; 1, 1 ,1 ;0 , 0, 0];



disp("Analyzing  Map")
disp("Number of cells")
disp(rows(map)*columns(map))

NodeZ = struct();
NodeZ.id = 0;
previous = NodeZ;

# Create graph from grid
g = populate_graph_from_ogrid(map);

disp("Numer of obstacles: ")
disp(g.obstacles)
disp(g.id_table)

if plotting
  aug_map = zeros(rows(map)+2,columns(map)+2)
  aug_map([2:end-1],[2:end-1]) = map
  aug_map(end,:) = 1;
  aug_map(1,:) = 1;
  aug_map(:,1) = 1;
  aug_map(:,end) = 1;
  pcolor(aug_map)
endif

# Check for Forests -> Retrieve impossible