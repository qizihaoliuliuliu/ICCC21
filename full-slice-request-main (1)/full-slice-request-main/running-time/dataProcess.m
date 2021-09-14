function dataProcess()

load singleData/Value_State_record.mat %figure 1
load singleData/price_record.mat %price iteration plot figure 2
load singleData/X_recourse_record.mat %X_recourse iteration plot figure 3
% size(Value_State_record)
% size(price_record)
% size(price_record)

%figure 4
load singleData/Phi
load singleData/Phi_Greedy.mat
load singleData/Phi_MMF.mat

load singleData/State_Space.mat

load singleData/X_Recourse_Unit_Optimal.mat
load singleData/X_Recourse_Unit_Greedy.mat
load singleData/X_Recourse_Unit_MMF.mat

load singleData/Value_State.mat%最优值函数
load singleData/Price_Optimal.mat%价格




[State_Space_Row,State_Space_column]=size(State_Space);
reward_optimal=zeros(State_Space_Row,State_Space_column);
reward_Greedy=zeros(State_Space_Row,State_Space_column);
reward_MMF=zeros(State_Space_Row,State_Space_column);
for j =1:State_Space_column
for i =1:State_Space_Row
    
        state=State_Space{i,j};%状态共用
        Price_new=Price_Optimal{i,j};%售价共用
        %得到Optimal reward
        optimal_action=Phi(i,j);%最优action
        optimal_X_recourse=X_Recourse_Unit_Optimal{i,j};%最优x分配
        reward_optimal(i,j)=GetActionValue(state,optimal_action,Value_State,optimal_X_recourse,Price_new);
        
        %得到Greedy reward
        Greedy_action=Phi_Greedy(i,j);%最优action
        Greedy_X_recourse=X_Recourse_Unit_Greedy{i,j};%最优x分配
        reward_Greedy(i,j)=GetActionValue(state,Greedy_action,Value_State,Greedy_X_recourse,Price_new);
        
        %得到MMF reward
        MMF_action=Phi_MMF(i,j);%最优action
        MMF_X_recourse=X_Recourse_Unit_MMF{i,j};%最优x分配
        reward_MMF(i,j)=GetActionValue(state,MMF_action,Value_State,MMF_X_recourse,Price_new);
    end
    
end
save (['singleData/reward_optimal'],'reward_optimal');
save (['singleData/reward_Greedy'],'reward_Greedy');
save (['singleData/reward_MMF'],'reward_MMF');
end


