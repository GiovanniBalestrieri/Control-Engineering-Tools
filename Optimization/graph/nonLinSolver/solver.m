% Limitations : It fsolve gives only one root. F must be continous
% change the initial conditions and re run

func = @fun;
x0 = [1,1];

options = optimoptions('fsolve','Display'...
    ,'none','PlotFcns',@optimplotfirstorderopt);
x = fsolve(func,x0,options);
disp(x);