function Price_Optimal_initial = GetPriceInitial()
%GETPRICEINITIAL 此处显示有关此函数的摘要
%   此处显示详细说明
global pi_unit
global State_Space
[State_Space_Row,State_Space_column]=size(State_Space);
Price_Optimal_initial=cell(State_Space_Row,State_Space_column);
for i =1:State_Space_Row
    for j = 1:State_Space_column
        Price_Optimal_initial{i,j}=pi_unit;
    end
end
end

