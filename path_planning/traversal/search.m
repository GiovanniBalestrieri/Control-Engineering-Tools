function path = search(g)
  global cells_to_visit

  # Consider backtracking
  backtracking_step = 0;

  # Start from Source
  steps = 1;
  path{steps} = g.start;
  node_cur = g.start;

  # Update node structure with visited fieldname to 1
  g.nodes{g.start.id}.visited = 1;

  # remove start node form to_visit
  index = vindex(cells_to_visit,node_cur);
  if index > 0
    cells_to_visit{index} = [];
  endif

  while something_to_search(cells_to_visit)
    
    steps++;
    cond = 1;
    
    # Loop through adjacent nodes
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
      else
        
        # Need to backtrack?
        if x == size(g.adjacencies{node_cur.id},2) && g.nodes{node_cur.id}.visited == 1
        
          if backtracking_step == 0
            backtracking_step++;
          else
            backtracking_step += 2;
          endif
                  
          #disp(g.nodes{path{end-backtracking_step}.id});
          node_cur = g.nodes{path{end-backtracking_step}.id};
          path{steps} = node_cur;
          
        endif
      endif        
    endfor      
  endwhile
endfunction