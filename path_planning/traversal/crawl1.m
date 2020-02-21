function crawl1(g,node_cur,cells_to_visit,steps, path)
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
            
            #disp("Found unvisited node with id")
            #disp(node_cur.id)
            
            # drop node from to_visit list
            index = vindex(cells_to_visit,node_cur);
            if index > 0
              cells_to_visit{index} = [];
            endif
            #disp("Flagging node as visited")
            g.nodes{node_cur.id}.visited = 1;
            #break
            crawl1(g,node_cur, cells_to_visit, steps);
        else
          disp("\t\t\tAlready visited node with id")
          disp(g.adjacencies{node_cur.id}{x}.id)
        endif
        
      endfor