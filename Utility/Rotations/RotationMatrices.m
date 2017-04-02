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




%% Other test rotate pi/2 around x, y and then z
% Let us start from x0 along the z axis
clf(figure(1))
x0 = [ 1; 1;0]

disp('another example with pi/2 -> 0 -> pi/2');
phi = pi/2;
theta = 0;
psi = pi/2;

% rotation matrix from body to inertial
Rb2i = RotationMatrix(phi,theta,psi);
xf = Rb2i*x0

% 3D plot to make it simple
P0 = [ 0; 0 ; 0];
figure(1)
plot3(1,0,0,'r*')
hold on;
plot3(0,1,0,'g*') 
hold on;
plot3(0,0,1,'b*') 
hold on;
quiver3(P0(1),P0(2),P0(3), x0(1),x0(2),x0(3))
axis equal
hold on
quiver3(P0(1),P0(2),P0(3), xf(1),xf(2),xf(3))
grid on
legend('x','y','z','x0','xf')

pause()
clf(figure(1))
% Another example
disp('another example with pi/2 -> pi/2 -> 0');

clf(figure(1))
x0 = [ 1; 1;0]

phi = pi/2;
theta = pi/2;
psi = 0;

% rotation matrix from body to inertial
Rb2i = RotationMatrix(phi,theta,psi);
xf = Rb2i*x0

% 3D plot to make it simple
P0 = [ 0; 0 ; 0];
figure(1)
grid on
plot3(1,0,0,'r*')
hold on;
plot3(0,1,0,'g*') 
hold on;
plot3(0,0,1,'b*') 
hold on;
quiver3(P0(1),P0(2),P0(3), x0(1),x0(2),x0(3))
axis equal
hold on
quiver3(P0(1),P0(2),P0(3), xf(1),xf(2),xf(3))
grid on
legend('x','y','z','x0','xf')


pause()
clf(figure(1))
% Last example
disp('Last example with pi/2 -> pi/2 -> pi/2');

x0 = [ 1; 1;0]

phi = pi/2;
theta = pi/2;
psi = pi/2;


% rotation matrix from body to inertial
Rb2i = RotationMatrix(phi,theta,psi);
xf = Rb2i*x0



% 3D plot to make it simple
P0 = [ 0; 0 ; 0];
figure(1)
grid on
plot3(1,0,0,'r*')
hold on;
plot3(0,1,0,'g*') 
hold on;
plot3(0,0,1,'b*') 
hold on;
quiver3(P0(1),P0(2),P0(3), x0(1),x0(2),x0(3))
axis equal
hold on
quiver3(P0(1),P0(2),P0(3), xf(1),xf(2),xf(3))
grid on
legend('x','y','z','x0','xf')

disp('We are expressing the rotated vector with respect to the inertial frame')
disp('Xinertial = RxRyRz xbody')

%% Finally let us try to explicitate this transformation

syms a b c
phi = a;
theta = b;
psi = c;

Rz(psi)*Ry(theta)*Rx(phi)

stateB = [ 0; 0;1];

% rotation matrix from body to inertial
Rb2i = RotationMatrix(phi,theta,psi)
stateI = Rb2i*state

% rotation matrix from inertial to body
Ri2b = Rb2i.'

