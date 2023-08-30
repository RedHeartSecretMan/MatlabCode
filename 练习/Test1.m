close all;clear;clc;
format long
a = 3; 
b = 5;
fun = @(x,y) a*x.^2 + b*y.^2;
q = integral2(fun,0,5,-5,0,'Method','iterated','AbsTol',0,'RelTol',1e-10);
disp(q);