function [check, v, time] = move_forward(Service1,Service2,dt,B,check, v, time, vmax)

% Prob acceleration 
probac = 0.7;
% Prob deceleration 
probdc = 1;
% Prob of random deceleration 
probrd = 0.7;
t_h = 1; % time factor 

[L,W] = size(check);

gap = zeros(L,W);
f = find(check==1);
for k=f'
    [i,j] = ind2sub([L,W], k); 
    d = check(i+1:end, j);
    gap(k) = min( find([d~=0;1]) )-1;
end
gap(end,:) = 0;

% rule

k = find((gap(f) > v(f)*t_h) & (v(f) + 1 <= vmax) & (rand(size(f)) <= probac));
v(f(k)) = v(f(k)) + 1;

k = find((v(f)*t_h > gap(f)) & (rand(size(f)) <= probdc));
v(f(k)) = gap(f(k));

k = find(rand(size(f)) <= probrd);
v(f(k)) = max(v(f(k)) - 1,0);

% 进入A区
booth_row1= ceil(L/2);  
for i = 2:W-1
    if (check(booth_row1,i) ~= 1)
        if (check(booth_row1-1,i) == 1)
            v(booth_row1 - 1 ,i) = 1;% enter into booth
        end
        check(booth_row1,i) = -3;
    else
        if (check(booth_row1+1,i) ~= 1)&(rand > exp(-Service1*dt))
            v(booth_row1,i) = 1; % out booths
        else
            v(booth_row1,i) = 0;
        end
     end
end

%进入B区

booth_row2= ceil(2*L/3);  
for i = 2:W-1
    if (check(booth_row2,i) ~= 1)
        if (check(booth_row2-1,i) == 1)
            v(booth_row2 - 1 ,i) = 1;% enter into booth
        end
        check(booth_row2,i) = -3;
    else

        if (check(booth_row2+1,i) ~= 1)&(rand > exp(-Service2*dt))
            v(booth_row2,i) = 1; % out booths
        else
            v(booth_row2,i) = 0;
        end
     end
end

%3b March
check(f) = 0;
check(f+v(f)) = 1;

time(f + v(f)) = time(f) + 1;
time(check~=1&check~=-1) = 0;

v(f + v(f)) = v(f);
v(check~=1 & check~=-1)=0;