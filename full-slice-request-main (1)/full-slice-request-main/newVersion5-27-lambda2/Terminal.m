function flag = Terminal(Value_State_new,Value_State)
%TERMINAL 此处显示有关此函数的摘要
%   此处显示详细说明
global  threshold
difference_value=Value_State_new-Value_State;
difference_value=abs(difference_value);
if max(difference_value)<threshold
    flag=1;
else
    flag=0;

end

