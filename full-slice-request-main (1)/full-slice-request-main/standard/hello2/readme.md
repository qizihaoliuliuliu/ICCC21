* 运行main.m文件，输出两个.mat文件（Phi.mat，Value_State.mat）
* 状态空间介绍

我们用一个二维cell数组来表示状态空间State_Space

行代表请求数量的状态

列代表剩余资源的状态

state=State_Space{i,j}为一个具体的状态。

State_Space(i,j)=[Space_state_reqeust(i),Space_state_networking(j),Space_state_storage(j),Space_state_computing(j)]，是一个四维数数组,因为资源有三种，所有加上请求数量总共是四维


* 动作空间介绍

Action_Space是基于当前状态请求数量生成的。

Action_Space = GetActionSpace(state);

格式为1维数组，而action则为一个具体的数字（做了简化）


* 转移概率介绍

[System_transition_probability] = GetTransitionProbability(state, state_next,action)

state：转移前的状态（是具体的状态，为一个四维数组）

state_next: 转移后的状态（也是具体的状态，为一个四维数组）

action: 在state状态下所采取的action,为一个具体的数字（做了简化，从一个数组简化成了一个非负整数）

action受到state的约束

system_transition_probability:从state+action--->state_next的概率

注：这里我用的是函数的形式来表达转移概率，和用表的方式的


* ImmediateReward介绍

function immediate_reward = GetImmediateReward(action_individual,recourse_type,state,action)

针对于一个状态state下进行一个动作action

其中的一个request所获得的reward(注意这里是一个具体的请求）

action_individual=0 or 1 %1代表admit 0 代表deny

recourse_type=1,2,3%代表三种资源种类

action为此状态下采取的动作（实数）

immediate_reward=utility-recource_cost-waiting_cost;%对应eq13

utility=GetUtility(action_individual,recourse_type);

recource_cost=GetRecourceCost(action_individual,recourse_type,state,action);

waiting_cost=GetWaitingCost(action_individual,recourse_type);


* 行为-值函数介绍

action_value=GetActionValue(state,action,Value_State)

得到一个状态（state）执行动作(action)后的行为值函数


* ODR算法

[Phi ,Value_State_new]= ODR_Algorithm(Value_State)

迭代一次后的Phi,和Value_State


* ValueFuntionIteration

[Phi,Value_State_new] = ValueFuntionIteration(Value_State)

不停迭代，直到最后所有的状态之间的差值小于threhold为之


* Phi

最优策略

Phi[i,j]=best_action of state(State_Space{i,j})

Value_State[i,j]=final value of state(State_Space{i,j})
