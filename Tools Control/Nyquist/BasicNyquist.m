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

P = zpk([1.3 -2],[-1 -2 -8 2],1);
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

figure(4)
title('Open Loop');
disp(sysM.a);
step(P)

% Closed loop

CL = feedback(sysM,eye(size(sysM.d,1));
figure(5)
title('Closed Loop');
step(CL)
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

