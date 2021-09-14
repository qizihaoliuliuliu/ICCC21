function [row,column] = GetStateLocation(state)
%GETSTATELOCATION 
%得到一个状态在状态空间的位置
%（md费了老大劲写出来的这个函数感觉在这个DEMO中没用上气死了）
%   此处显示详细说明
%state为一个具体的状态
%row,column为这个状态在State_Space中的位置

global State_Space 
[State_Space_Row State_Space_column]=size(State_Space);
for i=1:State_Space_Row
    for j=1:State_Space_column
        if(State_Space{i,j}==state)
            row=i;
            column=j;
            fprintf('row:%d\n',row);
            fprintf('column:%d\n',column);
        else
            continue
        end
    end
end
end
