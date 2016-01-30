function graphF
clear all
clc
xmin = -1;
xmax = 4;
step = 0.1;
numSamples = abs(xmax-xmin)*step^-1;
% Create figure
figure1 = figure('Position',[1 400 1200 600]);
%colormap('gray');
%axis square;
[X,Y] = meshgrid(xmin:step:xmax);
%Z=ex2(X,Y);
%Z=X.^3+Y.^2+3*X;
%Z = abs(X.^3);
%Z=Y.^4 + X.^4 - 3*X*Y;
%Z = 3*(X-Y).^3 - 4*(X-Y);
%Z = (1/2*(3*X.^2+2*X.*Y + 4*Y.^2) -7*X -6*Y).^2;


% Create subplot
subplot1 = subplot(1,2,1,'Parent',figure1);
view([124 34]);
grid('on');
hold('all');

% Create surface
surf(X,Y,Z,'Parent',subplot1);

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