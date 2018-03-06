function h = show_check(check, h, n)
%
% show_check  To show the check matrix as a image


[L, W] = size(check); %get its dimensions
temp = check;
temp(temp==1) = 0;

check(:,:,1) = check;
check(:,:,2) = check;
check(:,:,3) = temp;

check = 1-check;
check(check>1)=check(check>1)/6;


if ishandle(h)
    set(h,'CData',check)
    pause(n)
else
    figure('position',[20,50,200,700])
    h = imagesc(check);    
    hold on
    % draw the grid
    plot([[0:W]',[0:W]']+0.5,[0,L]+0.5,'k')
    plot([0,W]+0.5,[[0:L]',[0:L]']+0.5,'k')
    axis image
    set(gca, 'xtick', [], 'ytick', []);
    pause(n)
end