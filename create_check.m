function [check, v, time] = create_check(B, L, checklength)  %构建初始元胞

check = zeros(checklength,B+3); % 1 = people, 0 = empty, -1 = forbid, -3 = empty&booth 
v = zeros(checklength,B+2); % velocity of automata (i,j), if it exists
time = zeros(checklength,B+2); % cost time of automata (i,j) if it exists
[a,b]=size(check);
check(1:checklength,[1,b]) = -1; 
check(ceil(checklength/2),[2:2+B]) = -3;  
check(ceil(2*checklength/3),[2:2+B]) = -3;  
check(ceil(checklength/2)-1:ceil(2*checklength/3),(3*B)/4+2)=-1;
%left: angle of width decline for boundaries
toptheta = 1.3; 
bottomtheta = 1.5;

for col = 2:ceil(B/2-L/2) + 1
    for row = 1:(checklength-1)/2 - floor(tan(toptheta) * (col-1))
        check(row, col) = -1;
    end
    for row = 1:(checklength-1)/2 - floor(tan(bottomtheta) * (col-1))
        check(checklength+1-row, col) = -1;
    end
end

fac = ceil(B/2-L/2)/floor(B/2-L/2);
%right: angle of width decline for boundaries
toptheta = atan(fac*tan(toptheta));
bottomtheta = atan(fac*tan(bottomtheta));

for col = 2:floor(B/2-L/2) + 1
    for row = 1:(checklength-1)/2 - floor(tan(toptheta) * (col-1))
        check(row,B+4-col) = -1;
    end
    for row = 1:(checklength-1)/2 - floor(tan(bottomtheta) * (col-1))
        check(checklength+1-row,B+4-col) = -1;
    end
end