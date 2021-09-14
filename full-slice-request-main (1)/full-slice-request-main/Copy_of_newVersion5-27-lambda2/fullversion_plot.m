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
figure(1)
p7=plot(iter,Plot_reward_optimal,iter,Plot_reward_Greedy,iter,Plot_reward_MMF);

p7(1).LineWidth=1;
p7(1).LineStyle='-';
p7(1).Marker='o';
p7(2).LineWidth=1;
p7(2).LineStyle='-';
p7(2).Marker='s';
p7(3).LineWidth=1;
p7(3).LineStyle='-';
p7(3).Marker='x';
xlabel('\mu')
ylabel('reward')
legend({'OAR','Greedy','MMF'},'location','northeast')
set(gca,'fontname','times') 
set(gca,'fontsize',16')
axis([2,10,0 200])
saveas(gcf,"./FullFigure/Full_mu.fig");
saveas(gcf,"./FullFigure/Full_mu.eps" );
saveas(gcf,"./FullFigure/Full_mu.png");
fprintf("love");
end


