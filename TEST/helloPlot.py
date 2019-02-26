import numpy as np
import matplotlib.pyplot as plt

x=[0,1]
y=[0,1]
print("hello")


csfont = {'fontname':'Times New Roman'}
plt.figure()
plt.rcParams["font.family"] = "Times New Roman"
plt.title('New Tile')
plt.plot(x,y)
plt.savefig("easyplot.svg")
# plt.savefig("easyplot.emf")



## write your code related to basemap here

## plt.show()