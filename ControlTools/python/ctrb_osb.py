""" check-controllability-and-observability.py

Example to check the controllability and the observability of a state space system.
RMM, 6 Sep 2010
"""

from __future__ import print_function

import numpy as np  # Load the scipy functions
from control.matlab import *  # Load the controls systems library
from numpy.linalg import matrix_rank

# Parameters defining the system

m = 250.0  # system mass
k = 40.0   # spring constant
b = 60.0   # damping constant

# System matrices
A = np.array([[1, -1, 1.],
             [1, -k/m, -b/m],
             [1, 1, 1]])

B = np.array([[0],
             [1/m],
             [1]])

C = np.array([[1., 0, 1.]])

sys = ss(A, B, C, 0)

# Check controllability
Wc = ctrb(A, B)
print("Checking controllability")
#print("Wc = ", Wc)

print("Rank of P :" + str(matrix_rank(Wc)))
if matrix_rank(Wc) == matrix_rank(A):
    print("V\tcontrollable system")
else:
    print("X\tNon controllable system")
# Check Observability
Wo = obsv(A, C)
print("Wo = ", Wo)

print("Checking obesrvability")
#print("Wc = ", Wc)
print("Rank of P :" + str(matrix_rank(Wo)))
if matrix_rank(Wo) == matrix_rank(A):
    print("V\tObservable system")
else:
    print("X\tNon observable system")
