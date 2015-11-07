syms s;
a = 2;
k = 2*s;



L1 = [0 0 1; 0 1 0; 1 0 0];
L2 = [1 0 0; 0 a 0; 0 0 1];
L3 = [ 1 0 k ; 0 1 0; 0 0 1];

% Simmetria
L1*L2 - L2 * L1

L3*L2 - L2*L3

L1.*L3 - L3.*L1

L1.*L3.*L2 - L2.*L3.*L1

%% Pol inv

A=[1 2 3; 2 3 0 ; 1 0 1]
tzero(A)