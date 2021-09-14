function [Phi_MMF, X_Recourse_Unit_MMF] = BaselineMMF()
%GAMECONDUCTING 此处显示有关此函数的摘要
%   baseline scheme: Dominant Resource Fairness, in this case, it degenerates as max-min fairness 
global delta_recourse epsilon Resource_max_unit 
global State_Space x_recourse x_recourse_ub



[State_Space_Row,State_Space_column]=size(State_Space);
X_Recourse_Unit_Optimal=cell(State_Space_column,State_Space_column);
x_recourse_old=x_recourse;
x_recourse_new=x_recourse;
X_Recourse_Unit_MMF=cell(State_Space_column,State_Space_column);

for i=1:State_Space_Row
    for j=1:State_Space_column
        state=State_Space{i,j};
        %n_max_resource = floor(Resource_max_unit./(x_recourse_ub.*delta_recourse));
        n_max_block =  floor(([state(2) state(3) state(4) ])./(delta_recourse)); % 最大允许接入数量
        
        number = min([state(1)  n_max_block]);% 实际允许接入数量
        Phi_MMF(i,j) = number;
        if number==0
         X_Recourse_Unit_MMF{i,j}=[0 0 0 ]   ;
        else
        resource_average = Resource_max_unit./(number.*delta_recourse);
        resource_MMF = min([resource_average;x_recourse_ub]);
        X_Recourse_Unit_MMF{i,j} = resource_MMF;
        end
    end
end

end

