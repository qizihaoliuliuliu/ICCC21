function recource_cost = GetRecourceCost(action_individual,recourse_type,state,action,X_recourse_new,Price_new)
%GETRECOURCECOST 此处显示有关此函数的摘要
%   此处显示详细说明
global epsilon
global delta_recourse
%the z-th resource unit cost beta（以unit作为单位）
%Attention!here is using unit install block
beta=Price_new(recourse_type)+...
    epsilon(recourse_type)*action*delta_recourse(recourse_type)/...
    (state(2)+1);%对应eq10
%fprintf('beta:%d\n',beta);
recource_cost=action_individual*delta_recourse(recourse_type)*X_recourse_new(recourse_type)*beta;%对应eq11
%fprintf('recource_cost:%d\n',recource_cost);
end

