function [Phi_Greedy, X_Recourse_Unit_Greedy] = BaselineGreedy()
%GAMECONDUCTING 此处显示有关此函数的摘要
%   baseline scheme: for all requests, assign to the maximum resource capacity x_recourse_ub in turn until the total resource capacity is not met 
global delta_recourse epsilon Resource_max_unit 
global State_Space x_recourse x_recourse_ub

[State_Space_Row,State_Space_column]=size(State_Space);
X_Recourse_Unit_Greedy=cell(State_Space_column,State_Space_column);




for i=1:State_Space_Row
    for j=1:State_Space_column
        state=State_Space{i,j};
        n_max_resource = floor(Resource_max_unit./(x_recourse_ub.*delta_recourse));
        n_max_block =  floor(([state(2) state(3) state(4) ])./(delta_recourse)); 
        number = min([state(1) n_max_resource n_max_block]);
        
       Phi_Greedy(i,j)=number;
       
        if number==0
            X_Recourse_Unit_Greedy{i,j}=[0 0 0 ]   ;
        else
            X_Recourse_Unit_Greedy{i,j} = x_recourse_ub;
        end
     
    end
end

end

