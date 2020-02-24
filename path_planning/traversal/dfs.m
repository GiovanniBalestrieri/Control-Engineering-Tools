function dfs(pos)  
  global visited
  global g
  
  # Quit if already been here 
  if visited{pos} == 1
    return;
  endif
  
  # Print the id 
  disp(g.nodes{pos}.id)  
  # Flag current node as visited
  visited{pos} = true;
  
  # Call recursively itself for each adjacent node
  for x=1:size(g.adjacencies{pos},2)
    dfs(g.adjacencies{pos}{x}.id)
  endfor
  
endfunction