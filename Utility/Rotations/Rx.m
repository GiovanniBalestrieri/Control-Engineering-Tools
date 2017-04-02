function [ R ] = Rx( alpha )
%RX Summary of this function goes here
%   Detailed explanation goes here

R = [ 1 0 0 ; 0 cos(alpha) -sin(alpha) ; 0 sin(alpha) cos(alpha)];

end

