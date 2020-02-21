clear
clc

plotting = false



load maps
#map2
#map3

disp("Analyzing  Map1")
disp("Number of cells")
disp(rows(map1)*columns(map1))
NodeZ = struct();
NodeZ.id = 0;
previous = NodeZ;

  

map = [ 0, 1, 1;2, 1 ,1 ;0 , 1, 0]

g = populate_graph_from_ogrid(map);

disp("Numer of obstacles: ")
disp(g.obstacles)

if plotting
  pcolor(map)
endif

disp(g.id_table)
# Check for Forests -> Retrieve impossible