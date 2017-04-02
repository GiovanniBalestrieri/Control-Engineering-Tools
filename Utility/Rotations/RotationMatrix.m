function [ R ] = RotationMatrix( alpha,beta,gamma )
%RX Summary of this function goes here
%   Detailed explanation goes here

R =  Rx(alpha)*Ry(beta)*Rz(gamma);

end

