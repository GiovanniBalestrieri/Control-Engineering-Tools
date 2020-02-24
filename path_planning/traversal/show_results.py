from matplotlib import pyplot as plt
from matplotlib import colors
import numpy as np


# Import occupancy grid + starting point
data = np.genfromtxt('current_map.csv', delimiter = ',')
print(data)
# Import id_table
id_table = np.genfromtxt('map_id.csv', delimiter = ',')
# Import path
path = np.genfromtxt('path.csv', delimiter = ',')

print(path)



# Show grid
cmap = colors.ListedColormap(['Blue','red'])
plt.figure(figsize=(6,6))
plt.pcolor(data[::-1],cmap=cmap,edgecolors='k', linewidths=3)
plt.show()
