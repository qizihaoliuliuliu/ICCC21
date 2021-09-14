function [Phi,Value_State_new] = ValueFuntionIteration(Value_State,Price_Optimal_initial,X_Recourse_Unit_initial)
%VALUEFUNTION 此处显示有关此函数的摘要
%core
%   此处显示详细说明
global State_Space
Value_State_new=Value_State;
[State_Space_Row,State_Space_column]=size(State_Space);
Phi=[State_Space_Row,State_Space_column];
Value_State_record={};
i=0;
while true
    i=i+1;
    Value_State_record{i}=Value_State;
    [Phi ,Value_State_new]= ODR_Algorithm(Value_State,Price_Optimal_initial,X_Recourse_Unit_initial);
    
 if ~Terminal(Value_State_new,Value_State)
     Value_State=Value_State_new;
    continue;
 else
     save Value_State_record;
    break;
 end
end

end

