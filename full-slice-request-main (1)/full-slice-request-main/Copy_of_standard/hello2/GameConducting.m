function [Price_Optimal,X_Recourse_Unit_Optimal] = GameConducting(Price_Optimal_initial,Phi)
%GAMECONDUCTING 此处显示有关此函数的摘要
%   此处显示详细说明
%Output:
%Price_Optimal:a cell array with the same scale of State_Space
%Price_Optimal{i,j}=[pi_networking_optimal,pi_storage_optimal,pi_computing_optimal];
%Price_Optimal{i,j} is the optimal price for a speical state(State_Space{i,j})

%X_Recourse_Unit_Optimal:a cell array with the same scale of State_Space
%X_Recourse_Unit_Optimal{i,j}=[x_netwokring_optimal,x_storage_optimal,x_computing_optimal];
%X_Recourse_Unit_Optimal{i,j} is the optimal recourse location for a special
%state(State_Space{i,j})

global State_Space x_recourse
%part I 初始化参数
[State_Space_Row,State_Space_column]=size(State_Space);
Price_Optimal=cell(State_Space_Row,State_Space_column);
X_Recourse_Unit_Optimal=cell(State_Space_column,State_Space_column);
x_recourse_old=x_recourse;
x_recourse_new=x_recourse;
%part II 对每一个状态+action进行价格博弈
price_record={};
X_recourse_record={};
for i=1:State_Space_Row
    for j=1:State_Space_column
        state=State_Space{i,j};
        action=Phi(i,j);
        price_old=Price_Optimal_initial{i,j};
        price_new=Price_Optimal_initial{i,j};
        %下面两个参数调试时可以用到，可以看到price_change和x_change的变化
        price_change={};
        x_change={};
        z=0;
        while true
            z=z+1;
            price_old=price_new;
            x_recourse_old=x_recourse_new;
            price_change{z}=price_old;
            x_change{z}=x_recourse_old;
            x_recourse_new=GameGetBuyerOptimization(price_old,state,action);%Buyer博弈，得到最优x
            
            price_new=GameSellerOptimation(x_recourse_new,price_old,state,action);%Seller博弈，得到最优price
            if ~GameTerminal(x_recourse_new,x_recourse_old,price_new,price_old)
                
                continue
            else
                Price_Optimal{i,j}=price_new;
                X_Recourse_Unit_Optimal{i,j}=x_recourse_new;
                price_record{i,j}=price_change;
                X_recourse_record{i,j}=x_change;
                break;
            end
        end
    
    end
end


save price_record;
save X_recourse_record;
end

