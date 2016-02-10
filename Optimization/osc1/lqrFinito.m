clear all;
clc;

A=2;
B=2;
C=1;
D=0;

sys = ss(A,B,C,D);
%Calcolo retroazione dallo stato
disp('Uso la funzione lqr per calcolare il guadagno K (la retroazione dallo stato u=Kx)')
Q=2;
R=2;
K = lqr(sys.a,sys.b,Q,R);
disp('Matrice di guadagno K: [comando K = lqr(A,B,Q,R)]');
disp(K);
disp('Autovalori a ciclo chiuso: [comando eig(A-B*K)]');
eK = eig(sys.a-sys.b*K);
disp(eK);
disp('[Nota: retroazione negativa!]')

disp('Step response OL.Press X')
pause;
step(sys);

sysCL = ss(A-B*K,B,C-D*K,D);
step(sysCL)