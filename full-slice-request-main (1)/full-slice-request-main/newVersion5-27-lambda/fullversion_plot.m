function fullversion_plot()

%hold on!
load fullData/full_reward_optimal.mat;
load fullData/full_reward_Greedy.mat;
load fullData/full_reward_MMF.mat;

len=length(full_reward_Greedy);
iter=2:1:len+1;


Plot_reward_optimal=[];
Plot_reward_Greedy=[];
Plot_reward_MMF=[];

request_axis=5;
resource_axis=5;

for i =1:len
    reward_optimal=full_reward_optimal{i};
    reward_Greedy=full_reward_Greedy{i};
    reward_MMF=full_reward_MMF{i};
    Plot_reward_optimal(i)=reward_optimal(request_axis,resource_axis);
    Plot_reward_Greedy(i)=reward_Greedy(request_axis,resource_axis);
    Plot_reward_MMF(i)=reward_MMF(request_axis,resource_axis);
    
    
end
set(gca,'position',[0.15,0.15,0.8,0.8]);
set(gcf,'unit','normalized','position',[0.1,0.1,0.64,0.8]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'points');
set(gcf, 'PaperPosition', [0 0 640 480]);
figure(1)
p7=plot(iter,Plot_reward_optimal,iter,Plot_reward_Greedy,iter,Plot_reward_MMF);

p7(1).LineWidth=2;
p7(1).LineStyle='-';
p7(1).Marker='o';
p7(1).MarkerSize=15;
p7(1).Color='r';
p7(2).LineWidth=2;
p7(2).LineStyle='-';
p7(2).Marker='s';
p7(2).MarkerSize=15;
p7(2).Color='k';
p7(3).LineWidth=2;
p7(3).LineStyle='-';
p7(3).Marker='x';
p7(3).Color='b';
p7(3).MarkerSize=15;
set(gca,'fontsize',22')
grid on

xlabel('\lambda')
ylabel('Reward')
legend({'OAR','Greedy','MMF'},'location','northwest')
set(gca,'fontname','times') 
axis([2,10,0 200])

saveas(gca,"./FullFigure/Full_lambda.fig");
saveas(gca,"./FullFigure/Full_lambda.eps",'epsc' );
saveas(gca,"./FullFigure/Full_lambda.png");
fprintf("love");
end


