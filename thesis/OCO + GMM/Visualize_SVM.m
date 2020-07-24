function [] = Visualize_SVM(XC,YC,alpha,b,K,X,Y)
% Plots seperation line and confidence for a trained SVM. 
%
%   Inputs          XC      Training data
%                   YC      Training labels
%                   alpha   Optimized multipliers
%                   b       Optimized bias
%                   K       Kernel function
%                   X       Prediciton Data
%                   Y       Prediction Labels
n = 100;                            % Grid size
xmi = 1.1*min(min(X));             % Minimum X
xma = 1.1*max(max(X));             % Maximum X
Grid = linspace(xmi,xma,n);
f = zeros(100,100);
for i=1:length(alpha)
    for j=1:n
        for k=1:n
            f(j,k) = f(j,k) + alpha(i)*YC(i)*K([Grid(j) Grid(k)],XC(i,:));
        end
    end
end
hyp = f + b >= 0;
figure
mmin = abs(min(min(f+b))); mmax = max(max(f+b)); cmin = floor(50*mmin/(mmin+mmax)); cmax = ceil(50*mmax/(mmin+mmax));
cmap(1:cmin,:) = [linspace(0,1,cmin)' linspace(0,1,cmin)' ones(cmin,1)];
cmap(cmin+1:cmin+cmax,:) = [ones(cmax,1) linspace(1,0,cmax)' linspace(1,0,cmax)'];
image(Grid,Grid,f+b,'CDataMapping','scaled')
hold on
colormap(cmap)
contour(Grid,Grid,f+b,[0 0],'k-')
contour(Grid,Grid,f+b,[1 1],'r--')
contour(Grid,Grid,f+b,[-1 -1],'b--')
gscatter(X(:,2),X(:,1),Y,'br')
gscatter(XC(:,2),XC(:,1),YC,'kk')
hold on
legend off
str = sprintf('OCO in SVM');
title(str)
drawnow
figure
surf(f+b)
title('Decision surface')
end