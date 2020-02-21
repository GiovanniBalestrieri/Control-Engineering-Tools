clear
clc
###################################################
# Utility variables
###################################################
plotting = false
verbosity = 1

###################################################
# Path Planning
###################################################

load maps
map = [ 2, 0;
        0, 0];
#map = [ 2, 0 ,0 ,0;
         #0, 0 ,0 ,1];
         #0, 1, 0 ,0 ,0];
map = map

disp("Analyzing  Map")
disp("Number of cells")
disp(rows(map)*columns(map))

NodeZ = struct();
NodeZ.id = 0;
previous = NodeZ;

# Create graph from grid
global g = {}
g = populate_graph_from_ogrid(map);

## Path Planning
cost_fcn = 0;
cells_to_visit = {};
path = {}; # stores the result
for i=1:size(g.nodes,2)
  cells_to_visit{i} = g.nodes{i};
endfor

steps = 1;
# Step 0: Start from Source
path{steps} = g.start;
node_cur = g.start;
# set it to visited in the nodes list struct of the graph
g.nodes{g.start.id}.visited = 1;
# remove start node form to_visit
index = vindex(cells_to_visit,node_cur);
if index > 0
  cells_to_visit{index} = [];
endif

# Go to adj of cur_node
#function crawl(current_node)


function val = something_to_search(list)
  val = 0;
  for i=1:size(list,2)
    if ~isempty(list{i})
      val = 1;
     break 
    endif
  endfor
endfunction

disp(g.id_table)

#for node = 1:size(g.nodes
while something_to_search(cells_to_visit)

disp("Path so far")
for i=1:size(path,2)
  disp(path{i}.id)
endfor 
  steps++;
  
  if verbosity == 1
    disp("Iteration: ")
    disp(steps)
    disp("Current node:")
    disp(g.nodes{node_cur.id}.id)
    disp("Cells to Visit:")
    for i=1:size(cells_to_visit,2)
      if ~isempty(cells_to_visit{i})
        disp(cells_to_visit{i}.id)
      endif
    endfor 
  endif
    
  disp(" Unvisited Nodes so far")
    
    for i=1:size(g.nodes,2)
      if g.nodes{i}.visited == 0
        disp(g.nodes{i}.id)
      endif
    endfor
    
    disp("              Nieghbor")
    for x=1:size(g.adjacencies{node_cur.id},2)
      disp(g.nodes{g.adjacencies{node_cur.id}{x}.id}.id)
    endfor
    disp("")
  
      for x=1:size(g.adjacencies{node_cur.id},2)
      
        #if verbosity == 1
          disp("        Neighbor loop iter:  ")
          disp(x)
          disp("        Now Checking Node : ")
          disp(g.nodes{g.adjacencies{node_cur.id}{x}.id})
        #endif
        
        if g.nodes{g.adjacencies{node_cur.id}{x}.id}.visited == 0 # not visited yet
           cond = false;
          
            # Set current node to this
            node_cur = g.nodes{g.adjacencies{node_cur.id}{x}.id};
            path{steps} = node_cur;
            
            disp("Found unvisited node with id")
            disp(node_cur.id)
            
            # drop node from to_visit list
            index = vindex(cells_to_visit,node_cur);
            if index > 0
              cells_to_visit{index} = [];
            endif
            #disp("Flagging node as visited")
            g.nodes{node_cur.id}.visited = 1;
            break
            #crawl1(g,node_cur, cells_to_visit, steps);
        else
          disp("\t\t\tAlready visited node with id")
          disp(g.adjacencies{node_cur.id}{x}.id)
        endif
        
      endfor
      
  #disp("STOP ITERATION")
endwhile


disp("Numer of obstacles: ")
disp(g.obstacles)
disp(path)
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

disp("Remaining Cells to Visit:")
for i=1:size(cells_to_visit,2)
  if ~isempty(cells_to_visit{i})
    disp(cells_to_visit{i}.id)
  endif
endfor 

disp("Path")
for i=1:size(path,2)
  disp(path{i}.id)
endfor 
# Check for Forests -> Retrieve impossible