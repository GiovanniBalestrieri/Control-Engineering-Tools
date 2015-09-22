clc 
clear all
%%  SISO system
% Tf Realization 

P = zpk([1.3 -2],[-1 -2 -8],1);
sysM = canon(P,'modal');
sysC = canon(P,'companion');
%disp(sysC.a);
%disp(sysM.a);

% Jordan Form of A

[Tm1,JM] = jordan(sysC.a);
disp('Jordan Form:');
JM
Bj = Tm1\sysC.b
Cj = sysC.c*Tm1
%JC = jordan(sysC.a)

% Kalman decomposition

disp('Kalman decomposition:');
[G,U]=minreal(sysM);
Ak= U*sysM.a*U'
Bk = U*sysM.b
Ck = sysM.c*U'

disp('Controllabity:');
rank(ctrb(sysM.a,sysM.b))
disp('Observability:');
rank(obsv(sysM.a,sysM.c))

%% Mimo system
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


[Tm1,JM] = jordan(tenzoMin.a);
disp('Jordan Form:');
JM
Bj = Tm1\tenzoMin.b
Cj = tenzoMin.c*Tm1