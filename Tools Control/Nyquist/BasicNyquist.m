% Nyquist Stable plant

H = zpk([2 2 -3],[-2 -2 -2 -1],1)
IPGH = 1 + H;
nyquist(IPGH);


cLoop = feedback(IPGH,1)
figure(1)
title('Closed Loop');
step(cLoop)

figure(2)
title('Open Loop');
step(H)

%% Nyquist UNStable OL plant

H = zpk([2 2 -3],[2 2 -3 -1],1
IPGH = 1 + H;
nyquist(IPGH);


cLoop = feedback(IPGH,1)
figure(1)
title('Closed Loop');
step(cLoop)

figure(2)
title('Open Loop');
step(H)

%% Nyquist UNStable plant

P = zpk([1.3 -2],[-1 0 2],1);
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

figure(4)
step(P)
title('Open Loop');

% Sintesi compensatore LQR

Q=eye(size(sysM.a,2));
R=eye(size(sysM.b,2));
K=lqr(sysM.a,sysM.b,Q,R);

H = ss(sysM.a,sysM.b,K,zeros(size(sysM.d)));
disp('Eig of A');
eig(H.a)

figure(6)
step(H)
title('Open Loop - post sintesi');

% Determine numero giri da nyquist. Must be = to Pp = 2
IPGH = 1 + H;
nyquist(IPGH);


cLoop = feedback(IPGH,1)
figure(9)
step(cLoop);
title('Closed Loop post sintesi');

%%
H = zpk([2 2 -3],[-2 -2 -2 -1],1)
IPGH = 1 + H;
nyquist(IPGH);


cLoop = feedback(IPGH,1)
figure(1)
title('Closed Loop');
step(cLoop)

figure(2)
title('Open Loop');
step(H)

