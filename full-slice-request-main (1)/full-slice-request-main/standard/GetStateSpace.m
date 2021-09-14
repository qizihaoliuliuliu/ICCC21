function State_Space= GetStateSpace()
%GETSTATESPACE 此处显示有关此函数的摘要
%   此处显示详细说明
global Resource_networking_max_block Resource_storage_max_block Resource_computing_max_block Request_number_max
global delta_networking delta_storage delta_computing
Space_state_networking=CreateRecourseSpaceState(Resource_networking_max_block,delta_networking);
Space_state_storage=CreateRecourseSpaceState(Resource_storage_max_block,delta_storage);
Space_state_computing=CreateRecourseSpaceState(Resource_computing_max_block,delta_computing);
%将三者的状态空间用数组表示。

Space_state_recourse_number=length(Space_state_networking);
Space_state_recourse=[];
for i =1:Space_state_recourse_number
    temp=[Space_state_networking(i),Space_state_storage(i),Space_state_computing(i)];
    Space_state_recourse=[Space_state_recourse;temp];
end
%对于当前系统中排队请求的数量暂定上限为Request_number_max(20)人,那么请求数量的状态空间为[0,1,2,...,30]
Space_state_reqeust=CreateRequestNumberSpaceState(Request_number_max);
Space_state_reqeust_number=Request_number_max+1;%这里需要包含0这种情况
%状态空间为Space_state_reqeust_number,Space_state_networking,Space_state_storage,Space_state_computing四者的笛卡尔积
fprintf('the space state of request number:%d\n',Space_state_reqeust_number);
%这里我们将三者的状态空间数量应该设为一致，我们将n_i_networking的状态空间作为总状态空间数，
%因为实际上来说，这三种资源的状态是具有相关性的
fprintf('the space state of recourse number:%d\n',Space_state_recourse_number);
fprintf('whole state number:%d\n',Space_state_recourse_number*Space_state_reqeust_number)

%利用cell数组存储state
State_Space=cell(Space_state_reqeust_number,Space_state_recourse_number);
for i =1:Space_state_reqeust_number
    for j = 1:Space_state_recourse_number
        State_Space{i,j}=[Space_state_reqeust(i),Space_state_networking(j),Space_state_storage(j),Space_state_computing(j)];
    end
end

end

