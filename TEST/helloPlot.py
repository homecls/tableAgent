#import numpy as np
import matplotlib.pyplot as plt
from numpy import pi, arange, sin

t = arange(0.0, 0.5*pi, 0.01)
yt = sin(2*pi*t)*t

plt.figure()
plt.rcParams["font.family"] = "Times New Roman"
plt.title('New Title')
plt.plot(t,yt,'.-')
plt.savefig("easyplot.svg")
# plt.savefig("easyplot.emf")



## write your code related to basemap here

## plt.show()