################################################################################
#
# The following function creates a graph structure with 4 field names 
# from a two dimensional array map. map(i,j) € {"0","1","2) for free,obstacle
# and starting point
#
################################################################################
#
#                             Graph structure 
#
# graph.obstacles     Total # obstacles in the map
# graph.nodes         Cell array containing Node structure
#                      
#                       A node is a structure defined as follows
#                       NodeX = struct("id",id,"x",i,"y",j,"visited",0);
#
# graph.adjacencies   Cell array containing the adjacent nodes structures
#                     (soon the id of the node) for each node in graph.nodes 
# graph.id_table      Bidimenstional array with id of the corresponding cell
#
################################################################################

function Graph1 = populate_graph_from_ogrid(map)
  Graph1 = struct();
  Graph1.obstacles = 0;
  Graph1.nodes = {};
  Graph1.adjacencies = {};
    
  # Storing neighboring coordinates
  x_coords = {-1, 1, 0, 0};
  y_coords = {0, 0, 1, -1};
  
  # Initializing id table
  id_table = zeros(rows(map),columns(map));
  id = 1;
  
  # Analyzing Nodes
  for i=1:rows(map)
    for j=1:columns(map)
      # Create a node structure for each empty cell
      if map(i,j) != 1
        NodeX = struct("id",id,"x",i,"y",j,"visited",0);
        Graph1.nodes{id} = NodeX;
        id_table(i,j) = id;
        
        # Found it! Flagging the starting point
        if map(i,j) == 2
          Graph1.start = NodeX;
        endif
        
        id++;        
      else
        Graph1.obstacles++;
      endif
    endfor
  endfor
  
  # Ready to store id table
  Graph1.id_table = id_table;
  
  # Analyzing Connections  
  for i=1:rows(map)
    for j=1:columns(map)
    
      # Skip obstacles from the analysis
      if map(i,j) != 1
        # Initialize adj list of valid node
        id_cur = id_table(i,j);  
        
        Graph1.adjacencies{id_cur} = {};
        adj_id_new = 1;
        
        for i_i=1:size(x_coords,2)
          if i+x_coords{i_i} > 0 && i+x_coords{i_i} <= rows(map) && j+y_coords{i_i} <= columns(map) && j+y_coords{i_i} > 0
            if map(i+x_coords{i_i},j+y_coords{i_i}) != 1   
              id_point = id_table(i+x_coords{i_i}, j+y_coords{i_i});
              NodeXX = struct("id",id_point,"x",i+x_coords{i_i},"y",j+y_coords{i_i},"visited",0);
              Graph1.adjacencies{id_cur}{adj_id_new} = NodeXX;
              adj_id_new++;          
            endif
          endif
        endfor
        
    endfor
  endfor  
  disp("Graph created")
endfunction