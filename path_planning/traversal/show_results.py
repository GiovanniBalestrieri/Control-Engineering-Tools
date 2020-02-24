from matplotlib import pyplot as plt
from matplotlib import colors
import numpy as np
import time

# Import occupancy grid + starting point
data = np.genfromtxt('current_map.csv', delimiter = ',')
print(data)
# Import id_table
id_table = np.genfromtxt('map_id.csv', delimiter = ',')
# Import path
path = np.genfromtxt('path.csv', delimiter = ',')

print(id_table)
print(path)


#plt.ion()

# Show grid
plt.figure()
for i in range(0,len(path)):
	print(path[i])
	ind = np.argwhere(id_table == path[i])
	if len(ind)>0:
		# we have a match, let's change its value
		data[ind[0][0]][ind[0][1]] = i*2
		plt.pcolor(data[::-1],edgecolors='k', linewidths=3)
		plt.pause(0.05)

plt.show() 
