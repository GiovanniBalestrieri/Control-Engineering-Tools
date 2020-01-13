# bdalg-matlab.py - demonstrate some MATLAB commands for block diagram altebra
# RMM, 29 May 09
import control
import matplotlib.pyplot as plt
from control.matlab import *    # MATLAB-like functions
from numpy.linalg import matrix_rank
import numpy as np
import scipy as sp



def structural_properties_check(ss):
    Wc = ctrb(ss.A, ss.B)
    print("Checking structural properties for system:")
    print(ss)

    # Check controllability
    if matrix_rank(Wc) == matrix_rank(ss.A):
        print("V\tcontrollable system")
    else:
        print("X\tNon controllable system")

    # Check Observability
    Wo = obsv(ss.A,ss.C)
    if matrix_rank(Wo) == matrix_rank(ss.A):
        print("V\tObservable system")
    else:
        print("X\tNon observable system")


# System matrices
A = [[0, 1.], [-4, -1]]
B = [[0], [1.]]
C = [[1., 0]]
sys1ss = ss(A, B, C, 0)
structural_properties_check(sys1ss)
sys1tf = ss2tf(sys1ss)
print(sys1tf)

sys2tf = tf([1, 0.5], [1, 5])
sys2ss = tf2ss(sys2tf)
structural_properties_check(sys2ss)
print(sys2ss)
# Series composition
series1 = sys1ss + sys2ss
print(series1)
ser_tf = ss2tf(series1)
print(ser_tf)

structural_properties_check(series1)













w001rad = 1.    # 1 rad/s
# First order systems
pt1_w001rad = tf([1.], [1./w001rad, 1.])
ss1 = tf2ss(pt1_w001rad)
print(pt1_w001rad)



#sisotool(ss1)

m = margin(ss1)
print(m)

#fig = plt.figure()
#T,Y = step(ss1)
#plt.plot(T, Y)
#plt.show()


K = place(ss1.A, ss1.B, [ -5])
print(K)

# Creating cl sys
ss1_cl = ss(ss1.A - ss1.B*K, ss1.B*K, ss1.C, 0)
sisotool(ss1_cl)



plt.figure(9)
Yvec, Tvec = step(ss1_cl, np.linspace(0, 20))
plt.plot(Tvec.T, Yvec.T)
plt.show()
poles = pole(ss1_cl)
print(poles)
