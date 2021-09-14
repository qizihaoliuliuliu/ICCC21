function utility = GetUtility(action_individual,recourse_type,X_recourse_new)
%GETUTILITY 此处显示有关此函数的摘要
%   此处显示详细说明
global delta_recourse  utility_factor

delta=delta_recourse(recourse_type);
x=X_recourse_new(recourse_type);
utility=action_individual*utility_factor*log2(1+delta*x);
%fprintf('utility:%d\n',utility);
end

