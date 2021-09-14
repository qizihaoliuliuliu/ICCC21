load Value_State_record.mat %figure 1
load price_record.mat %price iteration plot figure 2
load X_recourse_record.mat %X_recourse iteration plot figure 3
% size(Value_State_record)
% size(price_record)
% size(price_record)

%figure 5
load Phi
load Phi_Greedy.mat
load Phi_MMF.mat

load X_Recourse_Unit_Optimal.mat
load X_Recourse_Unit_Greedy.mat
load X_Recourse_Unit_MMF.mat

load Value_State.mat%最优值函数
load Price_Optimal.mat

load reward_optimal.mat;%价格 figure 4
load reward_Greedy.mat;
load reward_MMF.mat;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure 1
%MDP value iteration process
%chose state=State_Space{1,1}
load State_Space;
state=State_Space{1,1};
[temp,value_state_iteration_times]=size(Value_State_record);
value_iteration_special_state=[];
for i =1:value_state_iteration_times
    value_iteration_special_state=[value_iteration_special_state,Value_State_record{i}(1,1)];
end

iteration_times=[];

for i=1:length(value_iteration_special_state)
    iteration_times=[iteration_times,i];
end
value_iteration_special_state
figure(1)
plot(iteration_times,value_iteration_special_state);
%title('the iteration of value state')
xlabel('iteration times')
ylabel('value of state')
saveas(gcf,"./Figure/iterationOfValueState.fig");
saveas(gcf,"./Figure/iterationOfValueState.eps", 'psc2');
saveas(gcf,"./Figure/iterationOfValueState.png");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure 2
%game iteration price change
%choose state = State_Space{1,1}
%choose first recourse
price_iteration=price_record{1,1};
price_iteration_x_axis=[];
for i=1:length(price_iteration)
    price_iteration_x_axis=[price_iteration_x_axis,i];
end

networking_price_iteration=[];
storage_price_iteration=[];
computing_price_iteration=[];
for i=1:length(price_iteration)
    networking_price_iteration=[networking_price_iteration,price_iteration{i}(1)];
    storage_price_iteration=[storage_price_iteration,price_iteration{i}(2)];
    computing_price_iteration=[computing_price_iteration,price_iteration{i}(3)];
    
end


figure(2)
p=plot(price_iteration_x_axis,networking_price_iteration,...
    price_iteration_x_axis,storage_price_iteration,...
    price_iteration_x_axis,computing_price_iteration);
p(1).LineWidth=1;
p(1).LineStyle='-';
p(1).Marker='o';
p(2).LineWidth=1;
p(2).LineStyle='-';
p(2).Marker='s';
p(3).LineWidth=1;
p(3).LineStyle='-';
p(3).Marker='x';
%set(1,'DefaultAxesLineStyleOrder',{'-o',':s','--+'})
%title('the iteration of price')
xlabel('the number of iterations')
ylabel('price')
legend('networking','storage','computing','Location','southeast')
saveas(gcf,"./Figure/iterationOfPrice.fig");
saveas(gcf,"./Figure/iterationOfPrice.eps", 'psc2');
saveas(gcf,"./Figure/iterationOfPrice.png");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure 3
X_iteration=X_recourse_record{1,1};
X_iteration_x_axis=[];
for i=1:length(X_iteration)
    X_iteration_x_axis=[X_iteration_x_axis,i];
end

networking_X_iteration=[];
storage_X_iteration=[];
computing_X_iteration=[];
for i=1:length(X_iteration)
    networking_X_iteration=[networking_X_iteration,X_iteration{i}(1)];
    storage_X_iteration=[storage_X_iteration,X_iteration{i}(2)];
    computing_X_iteration=[computing_X_iteration,X_iteration{i}(3)]; 
end
figure(3)
p3=plot(X_iteration_x_axis,networking_X_iteration,...
    X_iteration_x_axis,storage_X_iteration,...
    X_iteration_x_axis,computing_X_iteration);
p3(1).LineWidth=1;
p3(1).LineStyle='-';
p3(1).Marker='o';
p3(2).LineWidth=1;
p3(2).LineStyle='-';
p3(2).Marker='s';
p3(3).LineWidth=1;
p3(3).LineStyle='-';
p3(3).Marker='x';

%title('the iteration of x')
xlabel('the number of iterations')
ylabel('x')
legend('networking','storage','computing','Location','northeast')
saveas(gcf,"./Figure/iterationOfX.fig");
saveas(gcf,"./Figure/iterationOfX.eps", 'psc2');
saveas(gcf,"./Figure/iterationOfX.png");


%figure 4
%3-D bar
reward_optimal_new=reward_optimal(1:20,:);

h=bar3(reward_optimal_new)
xlabel('request number')
ylabel('recourse space')
zlabel('reward')
%title('reward of optimal')
colorbar
set(h,{'cdata'},cellfun(@(z)kron(z(2:6:end,2:3),ones(6,2)),get(h,'ZData'),'un',0))


%figure 5
%the percentage of allocate request
%choose the recourse max situation(in fact, the situtation can be choosed
%randomly.
%the number of choosen is Phi, Phi_Greedy, Phi_MMF
%Phi(:,20) the number is from 30~10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

optimal_number=Phi(1:21,1)';
Greedy_number=Phi_Greedy(1:21,1)';
MMF_number=Phi_MMF(1:21,1)';
optimal_percentage=[];
Greedy_percentage=[];
MMF_percentage=[];
max_number=state(1);
for i =1:length(optimal_number)
    
    state=State_Space{i,1};
    optimal_percentage(i)=100*(optimal_number(i)/state(1));
    Greedy_percentage(i)=100*(Greedy_number(i)/state(1));
    MMF_percentage(i)=100*(MMF_number(i)/state(1));
end
optimal_percentage=fliplr(optimal_percentage);
Greedy_percentage=fliplr(Greedy_percentage);
MMF_percentage=fliplr(MMF_percentage);

barNumber=[];
number=10:1:30;
% for i=1:length(number)
%  
%     barNumber=[barNumber
%         number(i),number(i),number(i)];
% end
% bar_percentage=[];
% for i=1:length(number)
%     bar_percentage=[bar_percentage
%         optimal_percentage(i),Greedy_percentage(i),MMF_percentage(i)];
% end
% 
figure(5)
%p5=bar(barNumber,bar_percentage);
p5=plot(number,optimal_percentage,number,Greedy_percentage,number,MMF_percentage);
p5(1).LineWidth=1;
p5(1).LineStyle='-';
p5(1).Marker='o';
p5(2).LineWidth=1;
p5(2).LineStyle='-';
p5(2).Marker='s';
p5(3).LineWidth=1;
p5(3).LineStyle='-';
p5(3).Marker='x';
% 
xlabel('request number')
ylabel('allocated percentage')
legend('OAR','Greedy','MMF')
saveas(gcf,"./Figure/allocatedPercentage.fig");
saveas(gcf,"./Figure/allocatedPercentage.eps", 'psc2');
saveas(gcf,"./Figure/allocatedPercentage.png");

figure(6)

optimal_reward=reward_optimal(1:21,2)';
Greedy_reward=reward_Greedy(1:21,2)';
MMF_reward=reward_MMF(1:21,2)';
number=10:1:30;
optimal_reward=fliplr(optimal_reward);
Greedy_reward=fliplr(Greedy_reward);
MMF_reward=fliplr(MMF_reward);
p6=plot(number,optimal_reward,number,Greedy_reward,number,MMF_reward);
p6(1).LineWidth=1;
p6(1).LineStyle='-';
p6(1).Marker='o';
p6(2).LineWidth=1;
p6(2).LineStyle='-';
p6(2).Marker='s';
p6(3).LineWidth=1;
p6(3).LineStyle='-';
p6(3).Marker='x';
xlabel('request number')
ylabel('reward')
legend('OAR','Greedy','MMF')
barNumber=[];

% for i=1:length(number)
%  
%     barNumber=[barNumber
%         number(i),number(i),number(i)];
% end
% bar_reward=[];
% for i=1:length(number)
%     bar_reward=[bar_reward
%         optimal_reward(i),Greedy_reward(i),MMF_reward(i)];
% end
% p6=bar(barNumber,bar_reward);
% xlabel('request number')
% ylabel('reward')
% legend('optimal','Greedy','MMF')
%grid on
saveas(gcf,"./Figure/RewardCompare.fig");
saveas(gcf,"./Figure/RewardCompare.eps", 'psc2');
saveas(gcf,"./Figure/RewardCompare.png");


