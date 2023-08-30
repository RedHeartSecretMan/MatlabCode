clear ;
close all;
clc
h1=figure('name','心');
axis([-1.5 1.5 -2 0.5]);
axis off;
set(gcf,'color','black');
n=4;
a=320;
m=10^(-a);
h11=line(NaN,NaN,'marker','.','linesty','-','erasemode','none','color','b');
x1=[];
y1=[];
for theta=pi/2:-2*pi/999:-3*pi/2
    r1=1+cos(theta+pi/2);
    x1=[x1;r1*cos(theta)];
    y1=[y1;r1*sin(theta)];
    set(h11,'xdata',x1,'ydata',y1);
    pause(m);
end
pause(1);
fill(x1,y1,'r');
axis off;
set(gcf,'color','black');
text(-0.23*n,-0.85,'大家好','fontsize',n*18,'color','b');
title('爱心','fontsize',18,'color','w');
pause(1);
x2=[];
y2=[];
h22=line(NaN,NaN,'marker','.','linesty','-','erasemode','none','color','y');
for theta=pi/2:-2*pi/999:-3*pi/2
    r2=1+cos(theta+pi/2);
    x2=[x2;r2*cos(theta)];
    y2=[y2;r2*sin(theta)];
    set(h22,'xdata',x2,'ydata',y2);
    pause(m^19);
end
h2=figure('name','心');
fill(x2,y2,'r');
text(-0.58,-0.85,'好！','fontsize',40,'color','y');
text(-0.10,-1.1,'才是真的','fontsize',20,'color','k');
title('爱心','fontsize',18,'color','w');
axis off;
set(gcf,'color','black');
pause(1)
x3=[];
y3=[];
h33=line(NaN,NaN,'marker','.','linesty','-','erasemode','none','color','b');
for theta=pi/2:-2*pi/999:-3*pi/2
    r3=1+cos(theta+pi/2);
    x3=[x3;r3*cos(theta)];
    y3=[y3;r3*sin(theta)];
    set(h33,'xdata',x3,'ydata',y3);
    pause(m^19);
end