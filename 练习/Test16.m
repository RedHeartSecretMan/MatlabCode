%%
a = [9,-5,3,7]; x = -2:0.01:5;
f = polyval(a,x); 
plot(x,f,'LineWidth', 2);
xlabel('x'); ylabel('f(x)');
set(gca,'FontSize', 14);

%%
p=[5 0 -2 0 1];
polyder(p)
polyval(polyder(p),7)

%%
x=-2:0.01:1;
a=conv([5 -7 5 10],[4 5 10]);
f=polyval(a,x);
plot(x,f);
polyder(a)

%%
p=[5 0 -2 0 1];
polyint(p, 3)
polyval(polyint(p, 3),7)

%%
x = [1 2]; y = [5 7];
s=diff(y)./diff(x);
x0 = pi/2; h = 0.1;
x = [x0 x0+h];
y = [sin(x0) sin(x0+h)]; 
m=diff(y)./diff(x);

%%
x0=pi/2;h=0.1;m=zeros(7,1);
for i=1:7
    x=[x0 x0+h];
    y=[cos(x0) cos(x0+h)];
    a=diff(y)./diff(x);
    m(i,1)=a;
    h=h/10;
end
