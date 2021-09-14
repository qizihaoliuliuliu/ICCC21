function action_value=GetActionValue(state,action,Value_State,X_recourse_new,Price_new)
%GETACTIONVALUE 此处显示有关此函数的摘要
%得到某一状态（state）,执行动作action获得的行为值函数action_value（在很多书上用q来表示）

%   此处显示详细说明
%X_recourse_new是一个三维数组，代表在当前state状态下每一份delta请求所需要的资源数（game博弈过后滴）
%Price_new也是三维数组，代表每一unit所需要的价格（game博弈后的）
global gamma
global State_Space
%state是一个具体的状态，是一个四维数组
%State_Space是一个cell数组，数组中的每一个元素对应一个四维子数组
%Value_state为状态空间对应的值，是一个全局变量，在不久的将来会随着迭代不停的变化
%gamma discount factor, which is used to determine the weight of immediate and future rewards 
N_i=state(1);%请求个数

%下面部分依据eq24
%part I->eq24第一部分
%获得Immediate Reward(不过这里需要对所有资源种类(networking storage computing)，所有请求(N_i)都进行考虑）
action_value=0;%行为值函数初始化
%相对于论文我们省略了SP的多样化，其实本质是一样的。

    
for z=1:3%遍历所有的资源种类（networking,storage,computing）
%fprintf('z:%d\n',z);
    for a =1:action%在N_i个请求中，有action（这里action是一个具体的数字）个请求的action_individual为1
        action_value=action_value+ GetImmediateReward(1,z,state,action,X_recourse_new,Price_new);
        %fprintf('ImmediateReward%d\n',GetImmediateReward(1,z,state,action));
        
    end
        
    for b=1: N_i-action%在N_i个请求中,有（N_i-action）请求的action_individual为0
        action_value=action_value+GetImmediateReward(0,z,state,action,X_recourse_new,Price_new);
    end
end

%part II->eq24第二部分
%获得转以后的收益
%这里需要遍历所有的状态
%状态空间为State_Space
[row,column]=size(State_Space);
for i =1:row
    for j = 1:column
        state_next=State_Space{i,j};%获得转移后的下一状态
        state_next_value=Value_State(i,j);%获得下一状态的值函数
        transition_prob=GetTransitionProbability(state, state_next,action);
        
        action_value=action_value+gamma*transition_prob*state_next_value;%对应eq24后一部分
    end
end
 end


