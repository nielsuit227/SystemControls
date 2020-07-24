function [] = results(X)
global Tfinal
figure
for i=1:Tfinal+1
    hold on
    plot(X(1,i,1),X(2,i,1),'gd')
    plot(X(1,i,2),X(2,i,2),'ks')
    plot(X(1,i,3),X(2,i,3),'r*')
    plot(X(1,i,4),X(2,i,4),'bo')
    if i>1
        plot([X(1,i,1) X(1,i-1,1)],[X(2,i,1) X(2,i-1,1)],'g')
        plot([X(1,i,2) X(1,i-1,2)],[X(2,i,2) X(2,i-1,2)],'k')
        plot([X(1,i,3) X(1,i-1,3)],[X(2,i,3) X(2,i-1,3)],'r')
        plot([X(1,i,4) X(1,i-1,4)],[X(2,i,4) X(2,i-1,4)],'b')
%         axis([1.1*min(X(1,:,:)) max(X(1,:,:))*1.1 min(X(2,:,:))*1.1 1.1*max(X(2,:,:))+100]);
        axis([-100 100 -100 100])
    end
    pause(1)
end
legend('Plane 1','Plane 2','Plane 3','Plane 4')
        
    