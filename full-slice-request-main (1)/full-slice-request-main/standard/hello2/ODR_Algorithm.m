function [Phi ,Value_State_new]= ODR_Algorithm(Value_State,Price_Optimal_initial,X_Recourse_Unit_initial)
%ODR_ALGORITHM 此处显示有关此函数的摘要
%   此处显示详细说明
% Phi:最优化策略
%预计将Phi设定为一个数组，里面包含着最最优的策略
%对于state=State_Space{i,j}.
%它的最优化action为Phi(i,j)=action_best
%它的值函数为Value_State(i,j)
global State_Space
[State_Space_Row,State_Space_column]=size(State_Space);
Phi=zeros(State_Space_Row,State_Space_column);
Value_State_new=zeros(State_Space_Row,State_Space_column);
%part I 遍历所有状态
for i=1:State_Space_Row
    for j=1:State_Space_column
        
        state=State_Space{i,j};
        %part II 获得该状态下的动作空间
        Action_Space = GetActionSpace(state);
        %part III 遍历所有状态空间
        Action_Space_size=length(Action_Space);
        %提前做好准备
        action_value_best=0;
        action_best=0;
        X_recourse_new=X_Recourse_Unit_initial{i,j};
        
        Price_new=Price_Optimal_initial{i,j};
        for a=1:Action_Space_size
            action=Action_Space(a);
            %part IV 得到具体状态（state）,具体动作（action）下的状态值函数
            action_value=GetActionValue(state,action,Value_State,X_recourse_new,Price_new);
            %part V
            %找到所有动作中最大的action_value（记作action_value_best）,并得到对应的action(记作action_best）
            if action_value>action_value_best
                action_value_best=action_value;
                action_best=action;
            else
                continue
            end    
        end
        %part VI更新Value_State,选取最大的行为-状态值函数action_value_best
        Value_State_new(i,j)=action_value_best;
        Phi(i,j)=action_best;
    end
end



end

