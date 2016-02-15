function graphF

% Create figure
figure1 = figure('Position',[1 400 1200 600]);
%colormap('gray');
axis square;
[X,Y] = meshgrid(-2:0.1:2);
%Z=ex2(X,Y);
%Z=1/3*(X-2).^3 -X*Y.^2;
%Z = (1/2*(3*X.^2+2*X.*Y+2*Y.^2)-7*X -6*Y).^2
%Z = 1/2*(3*X.^2+2*X.*Y+1/3*Y.^2)-3*X +1*Y
Z = 3*(X-Y).^3 -4*(X-Y)

% Create subplot
subplot1 = subplot(1,2,1,'Parent',figure1);
view([124 34]);
grid('on');
hold('all');

% Create surface
surf(X,Y,Z,'Parent',subplot1,'LineStyle','none');

% Create contour


contour(X,Y,Z,'Parent',subplot1);

% Create subplot
subplot2 = subplot(1,2,2,'Parent',figure1);
view([234 34]);
grid('on');
hold('all');

% Create surface
surf(X,Y,Z,'Parent',subplot2,'LineStyle','none');

% Create contour
contour(X,Y,Z,'Parent',subplot2);
end