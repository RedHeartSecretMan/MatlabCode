function y = Rastrigin(x)
%输入x，给出相应的y值，在x=（0,0，...，0）处有全局极小点0
[r,~]=size(x);
if r>1
    error('输入的参数错误');
end
y=sum(x.^2-10*cos(2*pi*x)+10);
y=-y;
end