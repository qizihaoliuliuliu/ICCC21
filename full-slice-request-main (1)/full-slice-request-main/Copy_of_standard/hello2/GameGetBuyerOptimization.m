function x_recourse_new=GameGetBuyerOptimization(price,state,action)
%GAMEGETBUYEROPTIMIZATION 此处显示有关此函数的摘要
%output is a three dimension array[x_networking,x_storage,x_computing]
%this three dimension array reprsents the best recourse unit in a special
%state
%   此处显示详细说明
%part I get buyer optimization function
%refer eq24.
%only need to get the first part of eq24.(x only affect the first part)
%note:x only affect utiliy funcion and recourse cost function, therefore,
%we can ignore the wait cost.
%the simplify buyer optimization function


%part II
%using fmincon get the best x recourse allocation.
%using three times fmicon because the three recourse are independent.
%we just can analyse one by one.

global x_recourse recourse_kind_num utility_factor delta_recourse epsilon x_recourse_ub x_recourse_lb
len=recourse_kind_num;
x_recourse_new=zeros(1,recourse_kind_num);
for i=1:recourse_kind_num
    delta=delta_recourse(i);
    beta=price(i)+...
    epsilon(i)*action*delta_recourse(i)/...
    (state(2)+10^(-10));%得到beta,对应公式eq10
    fun=@(x)-(utility_factor*log2(1+delta*x)-delta_recourse(i)*x*beta);%得到优化函数
    options = optimoptions('fmincon','Display','off');
    nonlcon = [];
    %Q:why here is a minus symbol?
    %A:We try to get the max object funcion(eq25).however, we use fmincon,
    %fmincon only can get the minimum value of a function, therefore, we
    %add a minus, the minumum value of new funcion is negative of the max value of old
    %function. What's more, the x will not change.
    

    lb=x_recourse_lb(i);
    ub=x_recourse_ub(i);
    A=[];
    b=[];
    Aeq=[];
    beq=[];
    x0=x_recourse(i);
    [x,fval]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);%得到最优值函数
     x_recourse_new(i)=x;
end

