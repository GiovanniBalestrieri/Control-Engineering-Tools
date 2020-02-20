load maps
map1
map2
map3

disp("Analyzing  Map1")
disp("Number of cells")
disp(rows(map1)*columns(map1))

Graph1 = struct()
Graph1.obstacles = 0
id = 0
for i=1:rows(map1)
  for j=1:columns(map1)
    # Create a node structure for each empty cell
    if map1(i,j) != 1
      id++
      Node = struct("id",id,"coordX",i,"coordY",j,"visited",0)
      Graph1 
    else
      Graph1.obstacles++
    endif
  endfor
endfor

# Check for Forests -> Retrieve impossible