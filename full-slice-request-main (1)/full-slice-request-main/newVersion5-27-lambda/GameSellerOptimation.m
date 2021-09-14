function price_new=GameSellerOptimation(x_recourse,price,state,action);
%GAMESELLEROPTIMATION 此处显示有关此函数的摘要
%   此处显示详细说明
%Output:three demension array [pi_networking,pi_storage,pi_computing]

%Part I get seller optimation function
%Part II using fmincon get the best price.
%just similar to GamebuyerOptimation part II, the three kind resoucrse are
%independent. So we can analyse one by one.
global beta_0 recourse_kind_num utility_factor delta_recourse epsilon Resource_max_unit
global nu alpha
%nu lagrange multiplier.
%%step length in the iteration of nu
price_new=zeros(1,recourse_kind_num);
for i=1:recourse_kind_num
    x=x_recourse(i);
   
    %according to eq36
    dx_dpi=-utility_factor/...
        [log(2)*delta_recourse(i)*...
        [price(i)+epsilon(i)*action*delta_recourse(i)/...
    (state(2)+10^(-10))]^2];


    nu(i)=max(0,nu(i)-alpha*(Resource_max_unit(i)-action*delta_recourse(i)*x));
    %根据学长给的论文。更新拉格朗日乘子
    
    %here is simplify the eq33.the sum from j=1 to n_i(t) is reducted.
    price_new(i)=beta_0(i)+nu(i)-(x/dx_dpi);
    %这个是简化后的eq33,约掉了delta，和求和号
    
end

end

