% Let's define a non simmetric matrix A
disp('Let A be a 3x3 matrix');
A=[3 12 1;1 2 4;1 0 5]
% Asim is its asimmetric part
disp('We can express A as the sum of its simmetrix and asimmetric part');

asim = 1/2*(A-A')
% sim is its simmetric part
sim = 1/2*(A+A')

% The original matrix is the sum of its simmetric and asimmetrix matrix
sum=asim+sim
% this sould be zeros(3,3)
disp('A-sum(simm + asimm)'
A-sum

%% Quadratic form
disp('Only the simmetric part of a matrix contributes to the result of a quadratic form. Let x be:')
x= [1 1 1]'
disp('The quadratic form with x=[1;1;1] yields:');
pause();
x'*A*x
disp('which is the same result of the quadratic form of the simmertric part of A');

x'*sim*x
disp('Asimmetric part of A');
x'*asim*x