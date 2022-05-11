%%
student(1).name={'max','omg'};
student(1).id={'01','02','03','04','05'};
student(1).number=5;
student(1).grade=[100,90,98,50,88];
student(2).name={'linm','bob'};
student(2).id={'01','02','03','04','05'};
student(2).number=5; 
student(2).grade=[100,90,98,50,88];
%%
str = 'aardvark'; 
str=='a' ;
str(str == 'a') = 'Z'
%%
x=0:0.5:4*pi;
y=sin(x); h=cos(x); w=1./(1+exp(-x)); g=(1/(2*pi*2)^0.5).*exp((-1.*(x-2*pi).^2)./(2*2^2));
plot(x,y,'bd-' ,x,h,'gp:',x,w,'ro-' ,x,g,'c^-');		% 绘制多条图线
legend('sin(x)','cos(x)','Sigmoid','Gauss function');	% 添加图例
%%
subplot(2,2,1);
x = linspace(-3.8,3.8);
y_cos = cos(x);
plot(x,y_cos);
title('Subplot 1: Cosine')

subplot(2,2,2);
y_poly = 1 - x.^2./2 + x.^4./24;
plot(x,y_poly,'g');
title('Subplot 2: Polynomial')

subplot(2,2,[3,4]);
plot(x,y_cos,'b',x,y_poly,'g');
title('Subplot 3 and 4: Both')

%%
j=1;
for i=1:10
    if j<11
         xlswrite('Data.xlsx', w(1,j), i, 'A1');
         j=j+1;
    end
end