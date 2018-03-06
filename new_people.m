function [check, v, number_people] = new_people(Arrival, dt, check, v, vmax)

% Find the empty lanes of the entrance where a new car can be add.

unoccupied = find(check(1,:) == 0);  %找到能用的人行道
n = length(unoccupied); % number of available lanes  %可用通道的数量
number_people =min( poissrnd(Arrival*dt,1), n);  %旅客出现概率是泊松分布
if number_people > 0 
    x = randperm(n);  %整数无重复数列 
    for i = 1:number_people
         check(1, unoccupied(x(i))) = 1;
         v(1, unoccupied(x(i))) = vmax;
    end
end
