%% Rotation Matrices

% Giovanni Balestrieri aka UserK
% 2 / 04 /2017

%% Testing rotation matrix

theta = pi/2;
R = Ry(theta)
xb = [0 ;0; 1];
xi = R*xb


%% Basic test: transformation from body fixed frame to inertial frame

% suppose we have a thrust vector directed along the Zb axis of the
% quadrotor frame. 
% Suppose the orientation of the quad to be expressed by euler angles roll,
% pitch and yaw in the inertial frame:




phi = pi/2;
theta = 0;
psi = 0;
Rx(phi)
Ry(theta)
Rz(psi)
Rtot = RotationMatrix(phi,theta,psi)
stateB = [ 0; 0;1];
stateI = Rtot*state

% Rotation matrices are square matrices, with real entries. More specifically,
%they can be characterized as orthogonal matrices with determinant 1;
%that is, a square matrix R is a rotation matrix if RT = R^−1 and det R = 1.
Rtotm1 = Rtot'
% The resulting thrust vector in the inertial frame will be oriented along the negative y axis

%% Now let us try a different angle:

phi = pi/4;
theta = pi/9;
psi = 0;
Rtot = RotationMatrix(phi,theta,psi)
stateB = [ 0; 0;1];
stateI = Rtot*state


%% Other test rotate pi/2 around x, y and then z
% Let us start from x0 along the z axis

state0 = [ 0; 0;1];

phi = pi/2;
theta = pi/2;
psi = pi/2;

x1 = Rx(phi)*state0
x2 = Ry(theta)*x1
xf = Rz(psi)*x2
Rz(psi)*Ry(theta)*Rx(phi)

% rotation matrix from body to inertial
Rb2i = RotationMatrix(phi,theta,psi)
statef = Rb2i*state0

% 3D plot to make it simple
P0 = [ 0; 0 ; 0]
quiver3(P0(1),P0(2),P0(3), state0(1),state0(2),state0(3))
hold on
quiver3(P0(1),P0(2),P0(3), x1(1),x1(2),x1(3))
hold on
quiver3(P0(1),P0(2),P0(3), x2(1),x2(2),x2(3))
hold on
quiver3(P0(1),P0(2),P0(3), statef(1),statef(2),statef(3))
axis equal
legend('x0','x1','x2','xfinal')



%% Finally let us try to explicitate this transformation

syms a b c
phi = a;
theta = b;
psi = c;

Rz(psi)*Ry(theta)*Rx(phi)

stateB = [ 0; 0;1];
stateI = Rtot*state

% rotation matrix from body to inertial
Rb2i = RotationMatrix(phi,theta,psi)

% rotation matrix from inertial to body
Ri2b = Rb2i.'

