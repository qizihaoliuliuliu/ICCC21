function immediate_reward = GetImmediateReward(action_individual,recourse_type,state,action,X_recourse_new,Price_new)
%GETIMMEDIATEREWARD 此处显示有关此函数的摘要
%   此处显示详细说明
%针对于一个slice request，在action_individual(0 or 1)的指导下获得ImmediateReward
utility=GetUtility(action_individual,recourse_type,X_recourse_new);%对于一个请求，得到在action_individual的指导下某一种资源所获得的效应（注意，这里的action_individual的取值就只有1/0）

recource_cost=GetRecourceCost(action_individual,recourse_type,state,action,X_recourse_new,Price_new);%对于一个请求，得到在action_individual的指导下某一种资源所消耗的RecourceCost

waiting_cost=GetWaitingCost(action_individual,recourse_type);%对于一个请求，得到在action_individual的指导下某一种资源所消耗的waiting

immediate_reward=utility-recource_cost-waiting_cost;%对应eq13

%fprintf('immediate_reward%d\n',immediate_reward);
end

