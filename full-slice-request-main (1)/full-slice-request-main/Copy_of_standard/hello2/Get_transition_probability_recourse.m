function Transition_probability_n_i_recourse=Get_transition_probability_recourse(state,state_next,action)
%GET_TRANSITION_PROBABILITY_RECOURSE 此处显示有关此函数的摘要
%   此处显示详细说明
%state=[N_i,n_i_networking,n_i_storage,n_i_computing];
%action这里简化成了数字，代表N_i个slice 请求中admit的数量
%再次强调，这里我们仅分析了networking资源的概率，即将三种资源进行了“捆绑”
global lambda1 v
global delta_networking
global Resource_networking_max_block %networking资源的最大数量
%lambda1为到达流强度
%SPi的service rate,在计算资源转移概率中用到，论文里设置lambda1/v<1;

N_i=state(1);%当前状态下的slice request请求数量
remain_recource=state(2);
remain_recource_next=state_next(2);
rho=lambda1/v;%rho:load rate
eta=(1-rho)*(remain_recource/Resource_networking_max_block);%对应公式18，successfully leasing one resource 
%注：1. 这里我进行了简化，对于公式的分母部分，我直接用全部资源进行代替。（理论上是可行的，和学长进行讨论）
%      2. 学长论文里的单位是释放1unit的概率，不过这里我认为更加合理的应该是一个block
prob_leasing_one_slice_request=eta^delta_networking;%释放一个slice request所需资源的概率
% fprintf('eta%d\n',eta);
% fprintf('prob_leasing_one_block:%d\n',prob_leasing_one_slice_request);
prob_deny_one_slice_request=1-prob_leasing_one_slice_request;%拒绝释放一个slice request所需资源的概率
% fprintf('prob_deny_one_slice_request:%d\n',prob_deny_one_slice_request);
minimum_remain_recource_next=remain_recource-action*delta_networking;%全部通过请求后最小的可获得资源
%计算资源转移概率的思路为：
%在计算资源转移概率之前，首先要计算是否能够成功转移的一下概率。如果action全部通过都不能转移，那么概率就为零
%eg 一个请求需要1block资源，当action=3时候，无法从10转移到5，最大只能从10转移到7.所以此时概率为0
%还有一种情况，remain_recource_next>remain_recource概率也为0，因为咱这个模型就是个递减的。
%在action中，找出成功释放请求的个数，以及没有成功释放请求的个数。通过组合数来进行计算
%而成功释放一个请求的概率为prob_leasing_one_slice_request，那么没有成功释放一个请求的概率为（1-prob_leasing_one_slice_request）
if (minimum_remain_recource_next>remain_recource_next) || (remain_recource_next>remain_recource)
    Transition_probability_n_i_recourse=0;
    %fprintf('此情况资源转移概率为0，不可能转移到该状态\n');
else
    number_slice_request_leasing_success=(remain_recource-remain_recource_next)/delta_networking;%成功分配到资源的请求个数
    number_slice_request_leasing_deny=action-number_slice_request_leasing_success;%未分配到资源的个数
    %注：这里其实未分配是针对于action部分来说的。对于没有被action的请求本来就没有机会分配到资源。这里未分配是说你有了机会（action上了），最后也没得到资源。
    Transition_probability_n_i_recourse...
                                 =nchoosek(action, number_slice_request_leasing_success)*...
                                   (prob_leasing_one_slice_request^number_slice_request_leasing_success)*...
                                   (prob_deny_one_slice_request^number_slice_request_leasing_deny);%这就是一个简单的排列组合问题
%nchoosek(5,3)=C(5,3)=10;
% fprintf('Transition_probability_n_i_recourse:%d\n',Transition_probability_n_i_recourse);
%Transition_probability_n_i_recourse=1;
end

