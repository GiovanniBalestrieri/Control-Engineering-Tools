% Test uncertain system
clear all 
clc
%%
% Gravity cst 
g=9.81;

% Density of air [ kg*m^-3 ] 
% From 35°C to - 25°C
rho = ureal('rho',1.2250,'Range',[1.1455 1.4224]);

% Total mass of the quadrotor [Kg]
mq = ureal('mq',1.30,'Range',[0.800 1.5]);


% Mass of a motor (kg). 
% All motors have equal mass.
mm = ureal('mm',0.068,'Range',[0.067 0.095]);

% Motor length along x-axis,y-axis,z-axis (m). All motors have equal sizes.
lx = ureal('lx',28.8e-3,'Range',[0.0287 0.035]);
ly = ureal('ly',28.8e-3,'Range',[0.0287 0.035]);
lz = ureal('lz',0.04,'Range',[0.03 0.06]);

% Distance from the center of gravity to the center of a motor (m).
% The quadrotor is symmetric regarding to the XZ and YZ planes, so
% cg is the same for all motors.
dcg=0.288; 

% % Reali
dcgX = ureal('dcgX',0.32,'Range',[0.31 0.40]);
dcgY = dcgX; % ureal('dcgY',0.32,'Range',[0.31 0.40]);
dcgZ = ureal('dcgZ',0.04,'Range', [0.03 0.1]);

% % %Forzate
% dcgX = ureal('dcgX',0.288,'Range',[0.09 0.59]);
% dcgY = ureal('dcgY',0.288,'Range',[0.09 0.59]);
% dcgZ = ureal('dcgZ',0.03,'Range',[-0.20 0.40]);

% Moment of inertia (x-axis) for motors 1 and 3 (kg.m^2).
Ix1=(1/12)*mm*(ly^2+lz^2); 
% Moment of inertia (x-axis) for motors
% 2 and 4 (kg.m^2).
Ix2=(1/12)*mm*(ly^2+lz^2)+mm*dcgX^2;
% Total moment of inertia along the x-axis (kg.m^2)
Ixx=2*Ix1+2*Ix2; 
% Moment of inertia (y-axis) for motors
% 1 and 3 (kg.m^2).
Iy1=(1/12)*mm*(lx^2+lz^2)+mm*dcgY^2; 
% Moment of inertia (y-axis) for motors 2 and 4
% (kg.m^2).
Iy2=(1/12)*mm*(lx^2+lz^2); 
% Total moment of inertia along the y-axis (kg.m^2)
Iyy=2*Iy1+2*Iy2; 
% Moment of inertia (z-axis) for motors
% 1 and 3 (kg.m^2).
Iz1=(1/12)*mm*(lx^2+ly^2)+mm*dcgZ^2; 
% Moment of inertia (z-axis) for motors
% 2 and 4 (kg.m^2).
Iz2=(1/12)*mm*(lx^2+ly^2)+mm*dcgZ^2; 
% Total moment of inertia along the z-axis (kg.m^2)
Izz=2*Iz1+2*Iz2;
% Inertia matrix
II=diag([Ixx Iyy Izz]); 

% Inflow coefficient
If = ureal('If',-0.3559,'Range',[-0.4000 -0.1559]);

% % Thrust coefficient of the propeller and Power coefficient
cp = ureal('cp',0.0314,'Range',[0.0111 0.0465]);
ct = ureal('ct',0.0726,'Range',[0.0348 0.0980]);

% Propeller radius (m)
rp = ureal('rp',13.4e-2,'Range',[0.08 0.16]);

% Constant value to calculate the moment provided
% by a propeller given its angular speed (kg.m^2.rad^-1)
Km=cp*4*rho*rp^5/pi()^3; 
% Constant value to calculate the thrust provided
% by a propeller given its angular speed (kg.m.rad^-1) 
%Kt=ct*4*rho*rp^4/pi()^2; 
Kt=ct*rho*rp^4*pi();
% Constant that relates thrust and moment of a propeller.
Ktm=Km/Kt;

%X0c=w0c;
Ft0=mq*g;


disp('Loading Parameters ... [OK]');


%% Model definition

% Il sys non è osservabile. 
% Definiamo il sottosistema osservabile e raggiungibile
disp('Removing unobservable and unreachable modes from Tenzo.');
  
  AMin = [
        0 1 0 0 0 0 0 0;
        0 If 0 0 0 0 0 0;
        0 0 0 0 0 1 0 0; 
        0 0 0 0 0 0 1 0; 
        0 0 0 0 0 0 0 1; 
        zeros(3,8)];

% Define B matrix 

B = [zeros(5,4);
    0 0 0 1/mq; 
    zeros(3,4);
    1/Ixx 0 0 0;
    0 1/Iyy 0 0;
    0 0 1/Izz 0];

WTF = [     0   -lx*Kt  0  lx*Kt;
            ly*Kt  0  -ly*Kt  0;
            Ktm -Ktm Ktm -Ktm;
            -Kt -Kt -Kt -Kt];  

Bw = B*WTF;

% define B matrix related to wi anuglar velocities
BMinw = [Bw(3,:);Bw(6:end,:)];
 
outputsLocal = {'phi'; 'theta';'psi';'ze'};
ClocalMin = [  
            0 0 1 0 0 0 0 0; 
            0 0 0 1 0 0 0 0; 
            0 0 0 0 1 0 0 0;
            1 0 0 0 0 0 0 0];
        
        
D = zeros(4,4);


p = size(BMinw,2)
q = size(ClocalMin,1)
        
statesMin = {'ze','vze','phi','theta','psi','wxb','wyb','wzb'};
inputName = {'w1^2','w2^2','w3^2','w4^2'};

disp('x,y position and velocities have been removed.');
disp('When we linearize the non linear model, these informations are lost');

tenzo_min_unc = uss(AMin,BMinw,ClocalMin,D,'statename',statesMin,'inputName',inputName,'outputname',outputsLocal);
tenzo_min_nominale=tenzo_min_unc.NominalValue;


% Proprietà strutturali:

% Sistema Ben Connessi: Somma dei singoli stati che compongono i sistemi 
% sia pari alla dimensione dello stato del sistema complessivo
 n=size(tenzo_min_nominale.a,1);

% Verifica Raggiungibilità e Osservabilità
if (rank(ctrb(tenzo_min_nominale.a,tenzo_min_nominale.b))==size(tenzo_min_nominale.a,1))
    cprintf('text', 'System');
    cprintf('green', ' reachable '); 
    cprintf('text', [num2str(rank(ctrb(tenzo_min_nominale.a,tenzo_min_nominale.b))) '\n']);
else
    disp('Sistema Irraggiungibile');
end

if (rank(obsv(tenzo_min_nominale.a,tenzo_min_nominale.c))==size(tenzo_min_nominale.a,1))
    cprintf('text', 'System');
    cprintf('green', ' observable '); 
    cprintf('text', [num2str(rank(obsv(tenzo_min_nominale.a,tenzo_min_nominale.c))) '\n']);
else    
    disp('Sistema Non osservabile');
end

% Invariant zeros and Transmission Zeros
modello_tf = tf(tenzo_min_nominale);


%% LQR


% Stabilizzazione LQR

disp('Stabilizzazione mediante LQR dallo stato stimato');
disp('Press any key to continue.');
pause();

rho1 = 0.01;
rho2 = 1;
rho3 = 100;
alphaK = 0.9;
alphaKLQR = alphaK;

Q = tenzo_min_nominale.c'*tenzo_min_nominale.c;

%RieCmp = [1 0 0 0; 0 100000 0 0; 0 0 100000 0; 0 0 0 10000];
R = eye(size(BMinw,2));
R1 = rho1*eye(p);

Kopt_1 = lqr(tenzo_min_nominale.a+alphaK*eye(n) , tenzo_min_nominale.b, Q, R1);

tenzoLQR1=ss(tenzo_min_nominale.a-tenzo_min_nominale.b*Kopt_1,tenzo_min_nominale.b,tenzo_min_nominale.c,tenzo_min_nominale.d,'statename',statesMin,'inputname',inputName,'outputname',outputsLocal);

disp('X to continue');
pause();

disp('Displaying LQR with rho1');
disp('Eig sys 1 CC retroazione dallo stato:');
eig(tenzo_min_nominale.a - tenzo_min_nominale.b*Kopt_1)
figure(3);
step(tenzoLQR1);
hold on
title('Rho1 - CL  Lqr ');


% Ricostruzione dello stato con Kalman

disp('Ricostruzione dello stato con Kalman');
disp('Press any key to continue.');
pause();

%si ricorda che delta zita0=(A-VC)*zita0 +(B-VD)u + sommatoria (M-VN)*d +V*y

Q = eye(size(tenzo_min_nominale.a));
W = eye(size(tenzo_min_nominale.a));
R = eye(size(tenzo_min_nominale.c,1));
%disp('matrice  V per Kalman:');
V=lqr((tenzo_min_nominale.a+alphaK*eye(n))',tenzo_min_nominale.c',Q,R)';
%disp('Dimensione attesa [nxq]');
disp(size(V));

% Defining Observer's matrices
Aoss=tenzo_min_nominale.a-V*tenzo_min_nominale.c;
Bossw=[tenzo_min_nominale.b-V*D V]; % perche ho u,y,d come ingressi, si noti che B-vD ha dim di B ma anche V ha dim di B
Coss=eye(size(Aoss,1));
poss = size(Bossw,2);
qoss = size(Aoss,2);
Doss=zeros(size(Aoss,1),poss);

disp('Autovalori A-V*C');
disp(eig(tenzo_min_nominale.a-V*tenzo_min_nominale.c));

Kopt = Kopt_1;

%% 

% Number of tests
answer4 = input(['Please enter the number of experiments? (<1000)' char(10)]);
if isempty(answer4)
    answer4 = 10;
end
N = answer4;

% Prende alcuni campioni del sistema incerto e calcola bound su incertezze
for i=1:1:N
sys{i} = usample(tenzo_min_unc);
step(sys{i})
hold on
cprintf('text','.');
end


%%
disp('Step response for uncertain systems');
figure(12)

% Compute Closed Loop transfer functions
for i=1:N
    Ac_3 = sys{i}.a-sys{i}.b*Kopt_1-V*sys{i}.c;
    Bc_3 = V;
    Cc_3 = Kopt_1;
    Dc_3 = zeros(q,q);

    G_3 = ss(Ac_3,Bc_3,Cc_3,Dc_3);      % Sistema filtro di kalman + guadagno k ottimo
    H_LQR = series(sys{i},G_3);   % Connessione in serie all'impianto nominale
    Closed_Loop_LTR{i} = feedback(H_LQR,eye(q)); % Nuova matrice U_3 dopo LTR
    step(feedback(H_LQR,eye(q)));
    hold on;
    grid on;
    cprintf('text','.');
end