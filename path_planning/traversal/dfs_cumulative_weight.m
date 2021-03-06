function dfs_cumulative_weight(pos)  
  global visited_bis
  global g
  global count_bis
  
  # Quit if already been here 
  if visited_bis{pos} == 1
    return;
  endif
  
  # Flag current node as visited
  visited_bis{pos} = 1;
  count_bis += 1;
  
  # Call recursively itself for each adjacent node
  for x=1:size(g.adjacencies{pos},2)
    dfs_cumulative_weight(g.adjacencies{pos}{x}.id)
  endfor
  
endfunction