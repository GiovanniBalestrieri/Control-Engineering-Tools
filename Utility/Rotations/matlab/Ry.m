function [ R ] = Ry( alpha )
%RX Summary of this function goes here
%   Detailed explanation goes here

R = [ cos(alpha) 0 sin(alpha) ; 0 1 0;  -sin(alpha) 0 cos(alpha)];

end

