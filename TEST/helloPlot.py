#import numpy as np
import matplotlib.pyplot as plt
from numpy import pi, arange, sin

x=[0,1]
y=[0,1]

t = arange(0.0, 10*pi, 0.1)
yt = sin(2*pi*t)*t

print("hello")


csfont = {'fontname':'Times New Roman'}
plt.figure()
plt.rcParams["font.family"] = "Times New Roman"
plt.title('New Title')
plt.plot(t,yt,'.-')
plt.savefig("easyplot.svg")
# plt.savefig("easyplot.emf")



## write your code related to basemap here

## plt.show()