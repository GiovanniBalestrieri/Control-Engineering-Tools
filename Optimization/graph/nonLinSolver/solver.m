func = @fun;
x0 = [0,0];

options = optimoptions('fsolve','Display'...
    ,'none','PlotFcns',@optimplotfirstorderopt);
x = fsolve(func,x0,options)