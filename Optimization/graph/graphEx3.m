function graphF

% Create figure
figure1 = figure('Position',[1 400 1200 600]);
colormap('gray');
axis square;
[X,Y] = meshgrid(-1:0.1:1);
%Z=ex2(X,Y);
%Z=X.^3+Y.^2+3*X;
%Z = abs(X.^3);

Z=Y.^4 + X.^4 - 3*X*Y;

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