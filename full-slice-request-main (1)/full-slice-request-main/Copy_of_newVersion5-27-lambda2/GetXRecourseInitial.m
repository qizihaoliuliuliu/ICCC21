function X_Recourse_Unit_initial = GetXRecourseInitial()
%GETXRECOURSEINITIAL 此处显示有关此函数的摘要
%   此处显示详细说明
global x_recourse
global State_Space
[State_Space_Row,State_Space_column]=size(State_Space);
X_Recourse_Unit_initial=cell(State_Space_Row,State_Space_column);
for i =1:State_Space_Row
    for j = 1:State_Space_column
        X_Recourse_Unit_initial{i,j}=x_recourse;
    end
end
end


