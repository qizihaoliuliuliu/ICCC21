function [Resource_state_space] = CreateRecourseSpaceState(Resource_max_block,delta_recource)
%CREATERECOURSESPACESTATE 此处显示有关此函数的摘要
%   此处显示详细说明
%   input:Resource_max_block：当前系统的最大块容量（针对于某一种资源）
%   input:delta_block:接受一份slice request所需要的块数量（针对于某一种资源）
% output:Resource_state_space当前这种资源系统中所有状态
Resource_state_space=[];

while Resource_max_block>=0
    Resource_state_space=[Resource_state_space,Resource_max_block];
    Resource_max_block=Resource_max_block-delta_recource;
end
end

