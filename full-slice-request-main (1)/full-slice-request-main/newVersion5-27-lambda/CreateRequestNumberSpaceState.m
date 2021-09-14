function [Space_state_reqeust] = CreateRequestNumberSpaceState(Request_number_max)
%CREATEREQUESTNUMBERSPACESTATE 此处显示有关此函数的摘要
%   此处显示详细说明
Space_state_reqeust=[];
for i =0:1:Request_number_max
    Space_state_reqeust=[Space_state_reqeust,i];
end
    Space_state_reqeust =fliplr(Space_state_reqeust);


end

