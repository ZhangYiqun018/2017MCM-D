%main.m

% B = 检查口数量
% L = 检查口外的人行道数量
% iterations = 迭代（仿真）次数
% Arrival =  到达的平均总人数
% checklength =
% Service1 = A检查口的服务效率
% Service22 = B检查口pre效率
% Service2 = B检查口常规效率
% check = check matrix  1=旅客 0=empty -1=forbid -3=检查口
% v = velocity matrix
% vmax = max speed of 旅客
% time = time matrix
% dt = time step 
% t_h = time factor 物理时间因素
% scount =  在模拟中离开安检区的人（包含c和d）
% ttime = 所用时间
% influx = influx vector
% outflux = outflux vector
% timecost = time cost of 全体旅客
% h = handle of the graphics

clear
clc
iterations = 2000;  %循环次数
B = 4;              %行列为4
L = 4;
checklength = 70;   %长度为70
[check,v,time]=create_check(B,L,checklength);  %调用create_check函数
h=show_check(check,NaN,0.01);        %调用show_check函数

dt=1; %0.2
t_h=2;
vmax=2;
timecost=[];
for i=1:iterations
    Service1=poissrnd(0.13);
    Service2=poissrnd(0.13);
    Arrival=10;
[check,v,arrivalscount]=new_people(Arrival,dt,check,v,vmax);

h=show_check(check,h,0.02);

% rules
[check,v,time]=switch_lanes(check,v,time);
[check,v,time]=move_forward(Service1,Service2,dt,B,check, v, time, vmax);
[check,v,time,scount,ttime,sscount]=clear_boundary(B,check,v,time);
%flux calculations
influx(i)=arrivalscount;
outflux(i)=scount;
timecost=[timecost,ttime];
influxx(i)=sscount;
end
sumin=sum(influx);
sumout=sum(outflux);
sumpre=sum(influxx);
per=sumout/sumin;
newper=sumpre/sumout;
va=max(timecost)-round(mean(timecost));
h = show_check(check, h, 0.01);
title({strcat('B=',num2str(B))})
xlabel({strcat('in=',num2str(sumin)),...
    strcat('out=',num2str(sumout)),...
    strcat('pre=',num2str(sumpre)),...
    strcat('r1=',num2str(per)),...
    strcat('r2=',num2str(newper)),...
    strcat('va=',num2str(va)),...
    strcat('time = ', num2str(round(mean(timecost))))})%,'Rotation',270)
%set(get(gca,'xlabel'),'position',[12 76 110])