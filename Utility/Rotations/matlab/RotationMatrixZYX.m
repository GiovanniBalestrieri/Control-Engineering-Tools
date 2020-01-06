function [ R ] = RotationMatrixZYX( alpha,beta,gamma )
%        Z  Y X   

R =  Rz(gamma)*Ry(beta)*Rx(alpha);

end

