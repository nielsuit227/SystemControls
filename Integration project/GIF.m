clc ; close all ; clear all

load('ref_lqi.mat')

%%

nImages = length(Time);        
fig2 = figure;
filename2 = 'LQI.gif' ;
h1 = animatedline('Color','r','Linewidth',1.5); 
h2 = animatedline('Color','b','Linewidth',1.5) ;

for i = 1:150:nImages
    addpoints(h1,Time(i),Reference(i))
    drawnow
    hold on
    addpoints(h2,Time(i),Actual(i))
    drawnow 
    hold on
    xlim([0 45])
    ylim([0 1])
    grid on
    title(['Reference tracking t =' num2str(Time(i),2)])
    xlabel('Time [s]')
    ylabel('Input [-]')
    frame = getframe(fig2) ;
    im = frame2im(frame) ;
    
   [A,map] = rgb2ind(im,256);
    if i == 1
        imwrite(A,map,filename2,'gif','LoopCount',Inf,'DelayTime',0.0005);
    else
        imwrite(A,map,filename2,'gif','WriteMode','append','DelayTime',0.0005);
    end
end