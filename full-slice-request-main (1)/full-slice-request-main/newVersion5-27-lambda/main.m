 clc
clear
close all

FULLorSINGLE=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%part 1 初始化参数
global lambda1 lambda2 v gamma utility_factor SLC stage_duration_T cost_wait
global  epsilon pi_unit
global Request_number_max Resource_networking_max_block Resource_storage_max_block Resource_computing_max_block Resource_max_block Resource_max_unit
global delta_recourse x_recourse recourse_kind_num x_recourse_ub x_recourse_lb
global delta_networking delta_storage delta_computing
global State_Space
global threshold game_threshold
global beta_0
global nu alpha
global minimum

minimum=10^(-10);%设置的一个极小数，防止分母为零等数学计算用。
%初始化slice_request的相关参数
gamma=0.9;%discount factor, which is used to determine the weight of immediate and future rewards 
threshold=5%used in MDP value function
game_threshold=0.001;%usd in game
nu=[0,0,0];%the lagrange multiplilier
alpha=0.0001;%step length in the iteration of nu
Request_number_max=15;%SP系统中允许存在的最大的请求数量
Resource_networking_max_unit=20;%SP全部的networking资源，这里的单位为Unit     20*100Mbps
Rescource_storage_max_unit=20;%SP全部的storage资源，这里的单位为Unit               20GB
Resource_computing_max_unit=20;%SP全部的computing资源，这里的单位为Unit    40CPU
Resource_max_unit=[Resource_networking_max_unit,Rescource_storage_max_unit,Resource_computing_max_unit];

delta_networking=1;%一个slice_request请求了1块networking资源 100Mbps
delta_storage=1;%一个slice_request分别请求了2块storage资源 1GB
delta_computing=2;%一个slice_request分别请求了1块computing资源 2CPU
%
delta_recourse=[delta_networking,delta_storage,delta_computing];

x_networking=2;%1块（份）networking资源包含了x_networking unit networking 资源1GB
x_storage=2;%1块storage资源包含了x_storage unit storage资源 100Mbps
x_computing=1;%1块computing资源包含了x_computing unit computing资源  1CPU
%Each slice request requires 1 GB of storage resources, 2 CPUs for computing, and 100 Mbps of radio resources [44].

x_recourse=[x_networking,x_storage,x_computing];
recourse_kind_num=length(x_recourse);

x_recourse_ub=2*x_recourse;%上界，fmincon优化用
x_recourse_lb=0.5*x_recourse;%下界，fmincon优化用


%由于我们将来的计算均是以块来作为单位，我们需要将SP系统中的资源单位进行转化(从unit转换成“块block”）
%我们以networking资源为例，SP系统中共有Resource_networking_max_unit unit,而一个slice
%reuqest则需要x_networking unit networking资源，所以以块作为单位时，系统最大的networking块数为Resource_networking_max_unit/x_networking;
Resource_networking_max_block=Resource_networking_max_unit/x_networking;
Resource_storage_max_block=Rescource_storage_max_unit/x_storage;
Resource_computing_max_block=Resource_computing_max_unit/x_computing;
Resource_max_block=[Resource_networking_max_block,Resource_storage_max_block,Resource_computing_max_block];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%调参用
%II-A
lambda1=8;%每一阶段到达的泊松分布强度的参数为3
lambda2=2;%每一阶段离去的泊松分布强度的参数为2
v=10;%SPi的service rate,在计算资源转移概率中用到，论文里设置lambda1/v<1;

%II-B
%used in eq9
utility_factor=3.5;%utility function调参因子，对应论文中的\theta_{i,z}

%II-C
%used in eq10
epsilon_networking=0.45;%unit price of the networking recourse unit
epsilon_storage=0.2;%unit price of the storage recourse unit
epsilon_computing=0.4;%unit price of the computing recourse unit
epsilon=[epsilon_networking,epsilon_storage,epsilon_computing];%方便后续计算，将三者放置一个数组当中

%used in eq10
%将来博弈也会用到的价格
pi_networking_unit=0.6;%the fundamental recourse unit cost of networking
pi_storage_unit=0.8;%the fundamental recourse unit cost of storage
pi_computing_unit=0.6;%the fundamental recourse unit cost of computing
pi_unit=[pi_networking_unit,pi_storage_unit,pi_computing_unit];%%方便后续计算，将三者放置一个数组当中

%这里used in eq26
beta_0=0.4*pi_unit;%Inp: the original price of one unit recourse.

%II-D
SLC=35;%slice request life cycle(其实就是生命周期）
stage_duration_T=5;%一个阶段的持续时间
%wait unit(block) cost of slice request
cost_wait_networking=0.1;
cost_wait_storage=0.1;
cost_wait_computing=0.1;
cost_wait=[cost_wait_networking,cost_wait_storage,cost_wait_computing];


%%
%Because full version, I have to add some experiment,therefore, I choose
%change the arrive rate.
%we choose change lambda from 5 to 15
fullversion_Phi_Greedy={};
fullversion_X_Recourse_Unit_Greedy={};
fullversion_Phi_MMF={};
fullversion_X_Recourse_Unit_MMF={};
fullversion_Phi={};
fullversion_Value_State={};
fullversion_Price_Optimal={};
fullversion_X_Recourse_Unit_Optimal={};
fullversion_State_Space={};

full_reward_optimal={};
full_reward_Greedy={};
full_reward_MMF={};
global fileID
    fileID=fopen('log.txt','w');  
    
for i=1:1
    lambda1=11;
    fprintf("the %d time\n",i);
         
    fprintf(fileID,"the %d time\n",i);
    fprintf(fileID,'\n'); 

        %%%%%%%%%%%%%%%%
%part2 创建状态空间-得到所有的状态空间
%State_Space二维状态空间：row代表所有的slice request number状态，column代表所有剩余资源状态。
%State_Space(i,j)代表一个具体的状态，是一个四维数数组[Space_state_reqeust(i),Space_state_networking(j),Space_state_storage(j),Space_state_computing(j)]
%State_Space是一个二维cell数组
    State_Space=GetStateSpace();



% baseline, greedy scheme
    [Phi_Greedy, X_Recourse_Unit_Greedy] = BaselineGreedy();
% baseline, max-min fairness
    [Phi_MMF, X_Recourse_Unit_MMF] = BaselineMMF();

    save (['singleData/Phi_Greedy'],'Phi_Greedy');
    save (['singleData/X_Recourse_Unit_Greedy'],'X_Recourse_Unit_Greedy');
    save (['singleData/Phi_MMF'],'Phi_MMF');
    save (['singleData/X_Recourse_Unit_MMF'],'X_Recourse_Unit_MMF');

fullversion_Phi_Greedy{i}=Phi_Greedy;
fullversion_X_Recourse_Unit_Greedy{i}=X_Recourse_Unit_Greedy;
fullversion_Phi_MMF{i}=Phi_MMF;
fullversion_X_Recourse_Unit_MMF{i}=X_Recourse_Unit_MMF;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%part3 初始化所有状态的值函数(一定和状态-行为值函数action_value区分开来）
%直接用一个二维数组来表示
[State_Space_Row,State_Space_column]=size(State_Space);
Value_State_initial=zeros(State_Space_Row,State_Space_column);

%[row,column] = GetStateLocation([0,0,0,0]);
%part5 the game part
Price_Optimal_initial=GetPriceInitial();
X_Recourse_Unit_initial=GetXRecourseInitial();
% for i=1:3
%     
%     [Phi,Value_State] = ValueFuntionIteration(Value_State_initial,Price_Optimal_initial,X_Recourse_Unit_initial)
%     fprintf("hello world i=%d\n",i);
%     [Price_Optimal,X_Recourse_Unit_Optimal]=GameConducting(Price_Optimal_initial,Phi);
% 
%     Price_Optimal_initial=Price_Optimal;
%     X_Recourse_Unit_initial=X_Recourse_Unit_Optimal;
% end
    [Phi,Value_State] = ValueFuntionIteration(Value_State_initial,Price_Optimal_initial,X_Recourse_Unit_initial);
    %fprintf("hello world i=%d\n",i);
    [Price_Optimal,X_Recourse_Unit_Optimal]=GameConducting(Price_Optimal_initial,Phi);

    Price_Optimal_initial=Price_Optimal;
    X_Recourse_Unit_initial=X_Recourse_Unit_Optimal;

save (['singleData/Phi'],'Phi');
save (['singleData/Value_State'],'Value_State');
save (['singleData/Price_Optimal'],'Price_Optimal');
save (['singleData/X_Recourse_Unit_Optimal'],'X_Recourse_Unit_Optimal');
save (['singleData/State_Space'],'State_Space');

fullversion_Phi{i}=Phi;
fullversion_Value_State{i}=Value_State;
fullversion_Price_Optimal{i}=Price_Optimal;
fullversion_X_Recourse_Unit_Optimal{i}=X_Recourse_Unit_Optimal;
fullversion_State_Space{i}=State_Space;

%process data

if FULLorSINGLE==1
    [full_reward_optimal,full_reward_Greedy,full_reward_MMF]=fullversion_data_process(i,full_reward_optimal,full_reward_Greedy,full_reward_MMF);

    save (['fullData/full_reward_optimal'],'full_reward_optimal');
    save (['fullData/full_reward_Greedy'],'full_reward_Greedy');
    save (['fullData/full_reward_MMF'],'full_reward_MMF');
end
fprintf('hello world\n');
end
fclose(fileID);
save (['fullData/fullversion_Phi'],'fullversion_Phi');
save (['fullData/fullversion_Phi_Greedy'],'fullversion_Phi_Greedy');
save (['fullData/fullversion_Phi_MMF'],'fullversion_Phi_MMF');

save (['fullData/fullversion_X_Recourse_Unit_Optimal'],'fullversion_X_Recourse_Unit_Optimal');
save (['fullData/fullversion_X_Recourse_Unit_Greedy'],'fullversion_X_Recourse_Unit_Greedy');
save (['fullData/fullversion_X_Recourse_Unit_MMF'],'fullversion_X_Recourse_Unit_MMF');

save (['fullData/fullversion_State_Space'],'fullversion_State_Space');
save (['fullData/fullversion_Value_State'],'fullversion_Value_State');
save (['fullData/fullversion_Price_Optimal'],'fullversion_Price_Optimal');


if FULLorSINGLE==1
    %%% FULL DATA PROCESS
%     %%%plot
%     fullversion_data_process();
    fullversion_plot();
    
else
    %%%
    dataProcess();
    PlotPlot();
end

