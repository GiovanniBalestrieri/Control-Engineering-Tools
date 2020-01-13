import control
# If you want to have a MATLAB-like environment, use the MATLAB
# compatibility module
from control.matlab import *
import os
import matplotlib.pyplot as plt   # MATLAB plotting function


# Parameters defining the system
m = 70.0           # system mass
k = 40.0            # spring constant
b = 60.0            # damping constant

# System matrices
A = [[0, 1.], [-k/m, -b/m]]
B = [[0], [1/m]]
C = [[1., 0]]
sys = ss(A, B, C, 0)

# Step response for the system
plt.figure(1)
yout, T = step(sys)
plt.plot(T.T, yout.T)
plt.show(block=False)

# Bode plot for the system
plt.figure(2)
mag, phase, om = bode(sys, logspace(-2, 2), Plot=True)
plt.show(block=False)

# Nyquist plot for the system
plt.figure(3)
nyquist(sys, logspace(-2, 2))
plt.show(block=False)

# Root lcous plot for the system
rlocus(sys)

if 'PYCONTROL_TEST_EXAMPLES' not in os.environ:
    plt.show()
