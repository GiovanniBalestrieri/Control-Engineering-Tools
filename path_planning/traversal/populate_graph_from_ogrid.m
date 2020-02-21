
function Graph1 = populate_graph_from_ogrid(map)
  id_table = zeros(rows(map),columns(map));
  Graph1 = struct();
  Graph1.obstacles = 0;
  Graph1.nodes = {};
  Graph1.adjacencies = {};

  # First loops through all cells and fill the table ids
  number_err = 0;
  id = 1;
  
  disp("Analyzing Nodes ")
  
  for i=1:rows(map)
    for j=1:columns(map)
      # Create a node structure for each empty cell
      if map(i,j) != 1
        NodeX = struct("id",id,"x",i,"y",j,"visited",0);
        Graph1.nodes{id} = NodeX;
        id_table(i,j) = id;
        
        # Flags the starting point
        if map(i,j) == 2
          Graph1.start = NodeX;
        endif
        id++;
        
      else
        Graph1.obstacles++;
      endif
    endfor
  endfor
  
  disp("Analyzing Connections ")
  
  for i=1:rows(map)
    for j=1:columns(map)
    
      # Skip obstacles from the analysis
      if map(i,j) != 1
        # Initialize adj list of valid node
        id_cur = id_table(i,j);  
        
        Graph1.adjacencies{id_cur} = {};
        adj_id = 1;
         
        # Update adjacency list using 4 neighbors 
        try
          if i-1 > 0 && map(i-1,j) != 1      
            id_point = id_table(i-1, j);
            NodeXX = struct("id",id_point,"x",i-1,"y",j,"visited",0);
            Graph1.adjacencies{id_cur}{adj_id} = NodeXX;
            adj_id++;
          endif
        catch
          number_err++;
          disp("Err i -1")
        end_try_catch
        
        try
          if i+1 <= rows(map) && map(i+1,j) != 1
            id_point = id_table(i+1, j);
            NodeXX = struct("id",id_point,"x",i+1,"y",j,"visited",0);
            Graph1.adjacencies{id_cur}{adj_id} = NodeXX;
            adj_id++;
          endif
        catch
          number_err++;
          disp("Err i + 1")
        end_try_catch
        
        try
          if j-1 > 0 && map(i,j-1) != 1 
            id_point = id_table(i, j-1);
            NodeXX = struct("id",id_point,"x",i,"y",j-1,"visited",0);
            Graph1.adjacencies{id_cur}{adj_id} = NodeXX;
            adj_id++;          
          endif
        catch
          number_err++;
          disp("Err J -1")
        end_try_catch
        
        try
          if j+1 <= columns(map) && map(i,j+1) != 1  
            id_point = id_table(i, j+1);
            NodeXX = struct("id",id_point,"x",i,"y",j+1,"visited",0);
            Graph1.adjacencies{id_cur}{adj_id} = NodeXX;
            adj_id++;
          endif
        catch
          number_err++;
          disp("Err J -1")
        end_try_catch
      endif      
    endfor
  endfor
  
  Graph1.num_err = number_err;
  Graph1.id_table = id_table;
  
  disp("Graph created")
endfunction