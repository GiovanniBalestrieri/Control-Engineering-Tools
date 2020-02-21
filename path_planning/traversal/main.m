clear all
clc
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
map = [ 0, 2, 0 ,1;
        0, 0, 0 ,0];
#map = [ 2, 0 ,0 ,0;
         #0, 0 ,0 ,1];
         #0, 1, 0 ,0 ,0];
         
disp("Analyzing  Map")
disp("Number of cells")
disp(rows(map)*columns(map))

# Create graph from grid
global g = {}
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


  if verbosity == 1
    disp("Path so far")
    for i=1:size(path,2)
      disp(path{i}.id)
    endfor 
  endif
  
  if steps == 8
    #break
  endif
  
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
  
  steps++;
    
    
  #{
  disp(" Unvisited Nodes so far")
  for i=1:size(g.nodes,2)
    if g.nodes{i}.visited == 0
      disp(g.nodes{i}.id)
    endif
  endfor
  #}
    
  if verbosity == 1
    disp("              Nieghbor")
    for x=1:size(g.adjacencies{node_cur.id},2)
      disp(g.nodes{g.adjacencies{node_cur.id}{x}.id}.id)
    endfor
    disp("")  
  endif
  
    cond = 1;
      for x=1:size(g.adjacencies{node_cur.id},2)
        if ~cond
          break
        endif
      
        if verbosity == 1
          disp("        Neighbor loop iter:  ")
          disp(x)
          disp("        Now Checking Node : ")
          disp(g.nodes{g.adjacencies{node_cur.id}{x}.id}.id)
        endif
        
        if g.nodes{g.adjacencies{node_cur.id}{x}.id}.visited == 0 # not visited yet
          
            # Set current node to this
            node_cur = g.nodes{g.adjacencies{node_cur.id}{x}.id};
            path{steps} = node_cur;
            
            if verbosity == 1
              disp("\t\t\tFound unvisited node with id")
              disp(node_cur.id)
            endif
            
            # drop node from to_visit list
            index = vindex(cells_to_visit,node_cur);
            if index > 0
              cells_to_visit{index} = [];
            endif
            #disp("Flagging node as visited")
            g.nodes{node_cur.id}.visited = 1;
            
            cond = 0;
            backtracking_step = 0;
            backtracking = 0;
        else
          
          if verbosity == 1
            disp("\t\t\tAlready visited node with this id")
            disp("\t\t\tChecking if last")
          endif
          
          # Need to backtrack?
          if x == size(g.adjacencies{node_cur.id},2) && g.nodes{node_cur.id}.visited == 1
          
            if verbosity == 1
              disp("\t\t\tGot to the end of adj list. Backtracking!")
            endif
            
            if backtracking_step == 1
              backtracking_step += 2;
            else
              backtracking_step++;
            endif
            backtracking_step
            backtracking = 1;
            
            disp(path{end-backtracking_step})
            node_cur = g.nodes{path{end-backtracking_step}.id};
            path{steps} = node_cur;
            
          else
          
            if verbosity == 1
              disp("\t\t\tContinue")
            endif
            
          endif
        endif
        
        
      endfor
      # Should apply backtracking go back to previous path
      
  #disp("STOP ITERATION")
endwhile


disp("Numer of obstacles: ")
disp(g.obstacles)
#disp(path)


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


disp("Cost function") 
cost_fcn = k1*size(path,2) #+ k2*phase 
disp(cost_fcn)
disp(g.id_table)

# Future Work 1: Check for Forests before starting