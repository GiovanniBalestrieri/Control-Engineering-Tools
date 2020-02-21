clear
clc
###################################################
# Utility variables
###################################################
plotting = false

###################################################
# Path Planning
###################################################

load maps
map = [ 0, 2; 0, 0];



disp("Analyzing  Map")
disp("Number of cells")
disp(rows(map)*columns(map))

NodeZ = struct();
NodeZ.id = 0;
previous = NodeZ;

# Create graph from grid
g = populate_graph_from_ogrid(map);

## Path Planning
cost_fcn = 0;
cells_to_visit = {};
path = {}; # stores the result
for i=1:size(g.nodes,2)
  cells_to_visit{i} = g.nodes{i};
endfor

# Start from Source
path{1} = g.start;
node_cur = g.start;
# set it to visited in the nodes list struct of the graph
g.nodes{g.start.id}.visited = 1
# remove start node form to_visit
index = vindex(cells_to_visit,node_cur)
if index > 0
  cells_to_visit{index} = []
endif
# Go to adj of cur_node

for x=1:size(g.adjacencies{node_cur.id},2)
  if g.adjacencies{x}.visited == 0 # not visited yet
    
  endif
endfor


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