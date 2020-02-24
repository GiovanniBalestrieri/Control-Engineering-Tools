clear all
clc
# Future Work 1: Check for Forests before starting
###################################################
# Utility variables
###################################################
plotting = false
verbosity = 1
###################################################
# Path Planning
###################################################
cost_fcn = 0;
k1 = 1;
k2 = 0;
backtracking = 0;
backtracking_step = 0;

load maps

problem_map_1 = [ 1, 0, 1 ,          1, 1 ,1 ,1 ,1 ,        1, 1, 1, 1, 1          , 1, 1, 1, 1, 1, 1   ;
                  1, 0, 1 ,          1, 1 ,1 ,1 ,1 ,        1, 1, 1, 1, 1          , 1, 1, 1, 1, 1, 1   ;
                  0, 0, 0 ,          0 ,0 ,0 , 0, 0,        0, 0, 0, 0, 0         , 0 ,0 ,0 , 0, 0, 0   ;
                  0, 0, 0 ,          0 ,0 ,0 , 0, 0,        0, 0, 0, 0, 0         , 0 ,0 ,0 , 0, 0, 0   ;
                  1, 0, 1 ,          1, 1 ,1 ,1 ,1 ,        1, 1, 1, 1, 1          , 1, 1, 1, 1, 1, 1   ;
                  1, 2, 1 ,          1, 1 ,1 ,1 ,1 ,        1, 1, 1, 1, 1         , 1, 1, 1, 1, 1, 1  ];


problem_map_2 = [ 0, 0, 0 , 0;
                  0, 0, 0 , 0;
                  0, 1, 1 , 1;
                  0, 0, 0 , 0;
                  0, 0, 0 , 2];

map = problem_map_2;        
# map = map3

# Create graph from grid
g = populate_graph_from_ogrid(map);


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

while something_to_search(cells_to_visit)
  
  steps++;
  
  cond = 1;
  for x=1:size(g.adjacencies{node_cur.id},2)
    if ~cond
      break
    endif
      
    # Check if node has been visited 
    if g.nodes{g.adjacencies{node_cur.id}{x}.id}.visited == 0 
        
        # Set current node
        node_cur = g.nodes{g.adjacencies{node_cur.id}{x}.id};
        path{steps} = node_cur;
                
        # Drop node from to_visit list
        index = vindex(cells_to_visit,node_cur);
        if index > 0
          cells_to_visit{index} = [];
        endif
        
        # Flagging node as visited
        g.nodes{node_cur.id}.visited = 1;
        
        cond = 0;
        backtracking_step = 0;
        backtracking = 0;
    else
      
      # Need to backtrack?
      if x == size(g.adjacencies{node_cur.id},2) && g.nodes{node_cur.id}.visited == 1
      
        if backtracking_step == 0
          backtracking_step++;
        else
          backtracking_step += 2;
        endif
        
        backtracking_step;
        backtracking = 1;
        
        #disp(g.nodes{path{end-backtracking_step}.id});
        node_cur = g.nodes{path{end-backtracking_step}.id};
        path{steps} = node_cur;
        
      endif
    endif        
  endfor      
endwhile

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