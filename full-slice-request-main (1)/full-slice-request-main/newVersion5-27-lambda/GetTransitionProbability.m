function [System_transition_probability] = GetTransitionProbability(state, state_next,action)
%GETTRANSITIONPROBABILITY 此处显示有关此函数的摘要
%   此处显示详细说明
global delta_recourse
Transition_probability_N_i=Get_transition_probability_N_i(state(1),state_next(1),action);
Transition_probability_n_i_networking=Get_transition_probability_recourse(state,state_next,action);

Transition_probability_n_i_storage=1;
Transition_probability_n_i_computing=1;
%这里解释一下为什么Transition_probability_n_i_storage，Transition_probability_n_i_computing均取值为1；
%eg：举一个例子，和仿真中的设置不一定一致
%假设当前状态下系统remain_resource为[20,30,40];假设同意给两个slice request分配资源（一个slice request请求三种资源为[2,2,1]）
%那么必然是当第一种资源同意分配后，第二种，第三种就不需要再次考虑概率。
%即从[20,30,40]->[16,26,38]
%要不然就乱套了。
%其实这里可以把这三种资源视为一种打包
System_transition_probability=Transition_probability_N_i*...
    Transition_probability_n_i_networking*...
    Transition_probability_n_i_storage*...
    Transition_probability_n_i_computing;
%fprintf('System_transition_probability:%d\n',System_transition_probability);
end

