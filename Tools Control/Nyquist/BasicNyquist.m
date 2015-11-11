% Nyquist Stable plant

H = zpk([2 2 -3],[-2 -2 -2 -1],1)
IPGH = 1 + H;
figure(1)
nyquist(IPGH);

figure(2)
step(H)
title('Open Loop');

cLoop = feedback(IPGH,1)
figure(3)
step(cLoop)
title('Closed Loop');

%% Nyquist Stable OL plant con coincidenza

H = zpk([2 2 -3],[2 2 -3 -1],1);
IPGH = 1 + H;
figure(4)
nyquist(IPGH);

figure(6)
step(H)
title('Open Loop');

cLoop = feedback(IPGH,1);
figure(5)
step(cLoop)
title('Closed Loop');


%% Nyquist UNStable plant

P = zpk([1.3 -2],[-1 5 2],1);
sysM = canon(P,'modal');
%disp(sysC.a);
disp('Realization of the following Transfer Function:');
disp(P);
disp('X');


autoval = eig(sysM.a);
for i= 1:size(sysM.a,1)
    disp('Testing autoval:');
    disp(autoval(i))
    if (autoval(i)>=0)
        disp('eig with non negative real part!!');
    else
        %disp('Ok');
    end
end

disp('Matrice dinamica');
disp(sysM.a);

figure(6)
step(P)
title('Open Loop');

% Sintesi compensatore LQR

Q=eye(size(sysM.a,2));
R=eye(size(sysM.b,2));
K=lqr(sysM.a,sysM.b,Q,R);
pert = rand(size(K))*1000;

H = ss(sysM.a,sysM.b,K-pert,zeros(size(sysM.d)));
disp('Eig of A');
eig(H.a)

figure(7)
step(H)
title('Open Loop - post sintesi');

% Determine numero giri da nyquist. Must be = to Pp = 2
IPGH = 1 + H;
nyquist(IPGH);


cLoop = feedback(H,1);
figure(8)
step(cLoop);
title('Closed Loop post sintesi');

%% Pole
% se molt(0) = dispari  ->   Rami all'INF Opposizione di fase
% se molt(0) = pari     ->   Rami all'INF in fase

P = zpk([1.3 -2],[-1 0 0 -2],1);
sysM = canon(P,'modal');
%disp(sysC.a);
disp('Realization of the following Transfer Function:');
disp(P);
disp('X');


autoval = eig(sysM.a);
for i= 1:size(sysM.a,1)
    disp('Testing autoval:');
    disp(autoval(i))
    if (autoval(i)>=0)
        disp('eig with non negative real part!!');
    else
        %disp('Ok');
    end
end

disp('Matrice dinamica');
disp(sysM.a);

figure(6)
step(P)
title('Open Loop');

% Sintesi compensatore LQR

Q=eye(size(sysM.a,2));
R=eye(size(sysM.b,2));
K=lqr(sysM.a,sysM.b,Q,R);

H = ss(sysM.a,sysM.b,K,zeros(size(sysM.d)));

figure(7)
step(H)
title('Open Loop - post sintesi');

% Determine numero giri da nyquist. Must be = to Pp 
IPGH = 1 + H;
nyquist(IPGH);

% compute closed loop 
cLoop = feedback(IPGH,1);

disp('Eig of AL');
eig(H.a)
disp('There are two eigenvalues with non negative Re(z)!!');

disp('Eig of ASigma');
eig(cLoop.a)

disp('How many encirclements the Nyquist plot makes around the point (-1,0)?');
disp('If two is the answer the Closed loop sys will be AS');

disp('Press X to continue');
pause();

% Display Closed Loop step response
figure(8)
step(cLoop);
title('Closed Loop post sintesi');

% Now try with
% 
P = zpk([1.3 -2],[-1 0 0 0 -2],1);
