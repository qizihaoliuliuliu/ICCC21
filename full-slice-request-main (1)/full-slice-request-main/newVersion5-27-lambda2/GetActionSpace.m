function Action_Space = GetActionSpace(state)
%GETACTIONSPACE 此处显示有关此函数的摘要
%由当前系统所处状态生成动作空间Action_Space(格式为1维数组）
%   此处显示详细说明
global delta_networking
Action_Space=[];
N_i=state(1);%当前系统中的请求数量，也可以理解为当前系统中请求数量可以转移的状态数
networking_max_block=state(2)/delta_networking;%当前系统中资源可以转移的状态数
max_action=min(N_i,networking_max_block);%最大的action值必须同时满足上述两个要求，否则就会超出限制
%eg:state=[15,10,20,10].15为当前请求数量，10,20,10为当前系统中剩余的资源数，
%假设一个请求所需要的资源块的数量为[1,2,1]那么action=min(15,10)=10.如果憨憨的取15，资源都会不够用了。
for i=0:max_action
    Action_Space=[Action_Space,i];
end

