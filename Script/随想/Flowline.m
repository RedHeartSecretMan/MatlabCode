%%
%基本方式
h = animatedline;
axis([0 4*pi -1 1])
x = linspace(0,4*pi,2000);
title('Flowline')
xlabel('x')
ylabel('sin(x)')

for k = 1:length(x)
    y = sin(x(k));
    addpoints(h,x(k),y);
    drawnow
end
%%
%速度控制
h = animatedline;
axis([0,4*pi,-1,1])
numpoints = 10000;
x = linspace(0,4*pi,numpoints);
y = sin(x);
a = tic;   % start timer
for k = 1:numpoints
    addpoints(h,x(k),y(k))
    b = toc(a);   % check timer
                  % elapsedTime = toc(timerVal) 返回自调用 timerVal 所对应 tic 命令以来的已用时间。
    if b > (1/1000)
        drawnow   % update screen every 1/1000 seconds
        a = tic;   % reset timer after updating 
    end
end
drawnow 