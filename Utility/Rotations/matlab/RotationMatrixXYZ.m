function [ R ] = RotationMatrixXYZ( alpha,beta,gamma )
%       X Y Z    

R =  Rx(alpha)*Ry(beta)*Rz(gamma);

end

