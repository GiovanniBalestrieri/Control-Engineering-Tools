%% Max singular values
clc 
clear all 

disp('Let us define a square matrix E');
E = [ 1 2 3; 4+i 5+i 6+i; 7 0 9]
disp('Eigenvalues of E:');
disp(eig(E))
% Es = transposed conjugate of E
Estar = conj(E).';
pause();

%% Let's consider E*xE and ExE*
clc
disp('The eigenvalues of E*E are all real and positive');
disp(eig(Estar*E))
% conj(E).' is the same as E'*E. Much quicker
%eig(E'*E)


disp('The non zero eigenvalues of E*E are the same of EE*');
disp(eig(E*Estar))
%eig(E*E')

%% Singular Values
clc
% computes singular values of E with matlab function
singularValuesE = svd(E)

% singular values of E are the square root of the eig(E*E)
disp('Square root of eig(E*E)');
disp(sort(sqrt(eig(Estar*E)),'descend'))