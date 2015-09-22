clc 
clear all
%%  SISO system
% Tf Realization 

P = zpk([1.3 -2],[-1 -2 -8],1);
sysM = canon(P,'modal');
sysC = canon(P,'companion');
%disp(sysC.a);
disp('Realization of the following Transfer Function:');
disp(P);
disp('X');
pause();
disp(sysM.a);

% Jordan Form of A

disp('Jordan Form of A. Press X');
pause();
[Tm1,JM] = jordan(sysC.a);
disp('Jordan Form:');
JM
Bj = Tm1\sysC.b
Cj = sysC.c*Tm1

% Kalman decomposition

disp('Kalman decomposition:');
disp('X');
pause();

[G,U]=minreal(sysM);
Ak= U*sysM.a*U'
Bk = U*sysM.b
Ck = sysM.c*U'


%% Mimo system

disp('Let s consider a Mimo system. That s quadcopter dynamic system');
disp('X');
pause();
If = 0.8;
mq = 1.2;
Ixx = 0.04;
Iyy = 0.44;
Izz = 0.21;

statesMin = {'ze','vze','phi','theta','psi','wxb','wyb','wzb'};
AMin = [
        0 1 0 0 0 0 0 0;
        0 If 0 0 0 0 0 0;
        0 0 0 0 0 1 0 0; 
        0 0 0 0 0 0 1 0; 
        0 0 0 0 0 0 0 1; 
        zeros(3,8)];

  
  BMin = [
    zeros(1,4);
    1/mq 0 0 0; 
    zeros(3,4);
    0 1/Ixx 0 0;
    0 0 1/Iyy 0;
    0 0 0 1/Izz];
  
outputsLocal = {'phi'; 'theta';'psi';'ze'};
ClocalMin = [  
            0 0 1 0 0 0 0 0; 
            0 0 0 1 0 0 0 0; 
            0 0 0 0 1 0 0 0;
            1 0 0 0 0 0 0 0];
       
D = zeros(4,4);
inputs = {'Thrust','TauPhi','TauTheta','TauPsi'};
tenzoMin = ss(AMin,BMin,ClocalMin,D,'statename',statesMin,'inputname',inputs,'outputname',outputsLocal)

%% Jordan form

disp('Eigenvalues of A:');
eig(tenzoMin.a)
% dimensions of the null space of A-0*I
rank(tenzoMin.a - eig(0)*eye(8))
% Or you can get it from here
size(null(tenzoMin.a - eig(0)*eye(8)),2)
% This will be the number of Jordan block for eig 0.
disp('X');
pause();

[Tm1,JM] = jordan(tenzoMin.a);
disp('Jordan Form:');
JM
Bj = Tm1\tenzoMin.b
Cj = tenzoMin.c*Tm1

Cif = [Cj(:,1) Cj(:,2) Cj(:,3) Cj(:,5) Cj(:,7)]
%% Proprietà strutturali

disp('Controllabity:');
rank(ctrb(tenzoMin.a,tenzoMin.b))
disp('Observability:');
rank(obsv(tenzoMin.a,tenzoMin.c))