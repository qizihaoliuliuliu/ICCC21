function waiting_cost = GetWaitingCost(action_individual,recourse_type)
%GETWAITINGCOST 此处显示有关此函数的摘要
%   此处显示详细说明
global SLC stage_duration_T cost_wait
waiting_cost=(1-action_individual)*ceil(SLC/stage_duration_T)*cost_wait(recourse_type);
%fprintf('waiting_cost%d\n',waiting_cost);
end

