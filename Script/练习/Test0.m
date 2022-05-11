clc;
clear;
fs = 48000;
y = audioread('C:\Users\王昊\Desktop\下午 2时36分 .ogg');
y = y(57000:end, 1);
n = 1;
x = [];
try
    while 1
    x = [x max(y(n:n+4))];
    n = n + 1;
    end
catch
    figure;
    sound(x, fs);
end
X = fft(x, length(x));
yfft = abs(X(1:floor(length(x)/2))) + abs(X(end:-1:ceil(length(x)/2+1)));
yfft(1:50) = 0;
yf = abs(yfft)/max(abs(yfft));
yf(yf < 1-0.7071) = 0;
plot(yf);
grid on;
hold on;
for i = 1 : 10
    plot([i i]*440, [0 1], 'r');
end
xlim([0 4400]);