%% Rotation Matrices

% Giovanni Balestrieri aka UserK
% 2 / 04 /2017

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
