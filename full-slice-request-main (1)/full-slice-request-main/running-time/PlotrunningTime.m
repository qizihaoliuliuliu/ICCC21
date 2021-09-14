load fullData/RunningTime.mat
a=156.5580;
RunningTime=[a,RunningTime]
requestNumber=15:5:40;
b=bar(requestNumber,RunningTime);
% b.FaceColor=[0.3010 0.7450 0.9330]
xlabel("The maximum number of slice requests")
ylabel("Rnning time in second")
set(gca,'fontname','times') 
set(gca,'fontsize',16')
grid on
saveas(gca,"./FullFigure/RunningTime.fig");
saveas(gca,"./FullFigure/RunningTime.eps",'epsc' );
saveas(gca,"./FullFigure/RunningTime.png");