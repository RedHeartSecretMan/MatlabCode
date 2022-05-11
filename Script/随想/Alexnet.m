clear;close,clc;
%%%初始化硬件与引擎
camera = webcam;   % 连接到摄像头
nnet = alexnet;   % 加载神经网络 

%%%调整图像大小为 227x227 像素，即 AlexNet 所需的大小。

while true  
picture = camera.snapshot;   % 抓取图片 
picture = imresize(picture,[227,227]);   % 调整图片大小 AlexNet 现在可对我们的图像分类。
label = classify(nnet, picture);   % 对图片分类 
image(picture);   % 显示图片 
title(char(label));   % 显示标签
drawnow;   
end