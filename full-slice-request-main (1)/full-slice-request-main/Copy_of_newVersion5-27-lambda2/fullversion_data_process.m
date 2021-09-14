function [full_reward_optimal,full_reward_Greedy,full_reward_MMF]=fullversion_data_process(iter,full_reward_optimal,full_reward_Greedy,full_reward_MMF)

% load fullData/fullversion_Phi
% load fullData/fullversion_Phi_Greedy.mat
% load fullData/fullversion_Phi_MMF.mat
% 
% load fullData/fullversion_X_Recourse_Unit_Optimal.mat
% load fullData/fullversion_X_Recourse_Unit_Greedy.mat
% load fullData/fullversion_X_Recourse_Unit_MMF.mat
% 
% load fullData/fullversion_Value_State.mat%最优值函数
% load fullData/fullversion_Price_Optimal.mat%价格
% load fullData/fullversion_State_Space.mat


load singleData/Phi.mat
load singleData/Phi_Greedy.mat
load singleData/Phi_MMF.mat



load singleData/X_Recourse_Unit_Optimal.mat
load singleData/X_Recourse_Unit_Greedy.mat
load singleData/X_Recourse_Unit_MMF.mat

load singleData/Price_Optimal.mat
load singleData/State_Space.mat
load singleData/Value_State.mat
    
%     Phi=fullversion_Phi{iter};
%     Phi_Greedy=fullversion_Phi_Greedy{iter};
%     Phi_MMF=fullversion_Phi_MMF{iter};
%     
%     X_Recourse_Unit_Optimal=fullversion_X_Recourse_Unit_Optimal{iter};
%     X_Recourse_Unit_Greedy=fullversion_X_Recourse_Unit_Greedy{iter};
%     X_Recourse_Unit_MMF=fullversion_X_Recourse_Unit_MMF{iter};
%     
%     
%     Price_Optimal=fullversion_Price_Optimal{iter};%价格
%     Value_State=fullversion_Value_State{iter};
%     State_Space=fullversion_State_Space{iter};
    [State_Space_Row,State_Space_column]=size(State_Space);
    reward_optimal=zeros(State_Space_Row,State_Space_column);
    reward_Greedy=zeros(State_Space_Row,State_Space_column);
    reward_MMF=zeros(State_Space_Row,State_Space_column);
    for i =1:State_Space_Row
        for j =1:State_Space_column
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
    full_reward_optimal{iter}=reward_optimal;
    full_reward_Greedy{iter}=reward_Greedy;
    full_reward_MMF{iter}=reward_MMF;
    
end




