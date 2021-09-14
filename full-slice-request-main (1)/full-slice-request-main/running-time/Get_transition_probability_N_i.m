function Transition_probability_N_i=Get_transition_probability_N_i(N_i,N_i_next,action);
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
% 这部分代码其实很容易，需要根据公式14来写出。
% 核心思路为：
%1. 建模出到达和离去的分布，这两个分布用泊松分布来模拟
%2. 这两个随机变量之差n=N_i_next-(N_i-action)的概率分布即为我们要求的思路
%当前问题的难点在于如何求得上述公式的概率。转为为两个泊松分布之差等于某个数值的时候的概率。
%设到达泊松流强度为lambda1
%离去泊松流强度为lambda2
global lambda1 lambda2
n=N_i_next-(N_i-action);
%https://www.docin.com/p-865689495.html
%查表得：
%当到达强度lambda=3时，当n_i^{a}>12时候n_i^{a}>12)<0.0001
%以下公式对于公式7
Transition_probability_N_i= exp(-(lambda1+lambda2))*(lambda1/lambda2)^(n/2)*besseli(n,2*sqrt(lambda1*lambda2));
%fprintf('Transition_probability_N_i:%d\n',Transition_probability_N_i);
end

