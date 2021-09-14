function game_terminal_flag = GameTerminal(x_recourse_new,x_recourse,price_new,price)
%GAMETERMINAL 此处显示有关此函数的摘要
%   此处显示详细说明
%
global game_threshold

difference_x_max=max(abs(x_recourse_new-x_recourse));
difference_price_max=max(abs(price_new-price));
if (difference_x_max<game_threshold)||(difference_price_max<game_threshold)
    game_terminal_flag=1;%terminal
else
    game_terminal_flag=0;%no terminal
end

