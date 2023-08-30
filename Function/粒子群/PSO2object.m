close all;clear;clc;                

%% ��������
tic;                                % ������ʼ
%f= @(x,y)x .* sin(x) .* exp(y) .* cos(2 * x) .* exp(2 * y) - 2 * x .* sin(3 * x) .* cos(3 * y);    % �������ʽ
f= @(a,b)(a .* sin(a) .* cos(2 * a) - 2 * a .* sin(3 * a)).*(b .* sin(b) .* cos(2 * b) - 2 * b .* sin(3 * b));    % �������ʽ

%% ��Ⱥ����
N = 500;                          % ��ʼ��Ⱥ����
d = 2;                            % �ռ�ά�������ݺ������ʽ�Ա�������
ger = 300;                        % ����������
plimit = [0,20;0,20];             % ����λ�ò�������(�������ʽ���Զ�ά)������2X2����
vlimit = [-1.5,1.5;-1.5,1.5];     % �����ٶ�����
w = 0.8;                          % ����Ȩ��,������ʷ�ɼ������ڵ�Ӱ��0.5~1֮�䣨��ͬ��Ȩ�����ú�Ӱ�����ܣ�����Ҫѡȡ��
c1 = 0.5;                         % ����ѧϰ����
c2 = 0.5;                         % Ⱥ��ѧϰ����

for i = 1:d
    x(:,i) = plimit(i, 1) + (plimit(i, 2) - plimit(i, 1)) * rand(N, 1);    % ��ʼ��Ⱥ��λ��
end                               % rand(N,1)����N��һ�з�Χ��1֮�ڵ������,��һ��,�ڶ��У�x=0+��20-0��*��1֮�ڵ��������

v = rand(N, d);                   % ��ʼ��Ⱥ���ٶ�,500��2�зֱ�������ά����
xm = x;                           % ÿ���������ʷ���λ��
ym = zeros(1, d);                 % ��Ⱥ����ʷ���λ�ã�����ά�ȣ�����Ϊ0
fxm = zeros(N, 1);                % ÿ���������ʷ�����Ӧ�ȣ�����Ϊ0
fym = -inf;                       % ��Ⱥ��ʷ�����Ӧ��,�����ֵ�����óɸ�����

figure(1);
[x1, x2]=meshgrid(0:0.2:20);    % ������������
y0=f(x1,x2);                    % ��������
mesh(x1,x2,y0);colorbar;                         
xlabel('��һά��X');
ylabel('�ڶ�ά��Y');
zlabel('����ֵ');
hold on
plot3(xm(:,1),xm(:,2),f(xm(:,1),xm(:,2)), 'k.');    %plot3����ά���򻭳��ռ��ϵĵ㣬�Ѹ�ʽ���óɡ�o��������ÿ��λ�õ�ɢ��ͼ��r��,g��,b��,c����,m�Ϻ�,y��,k��,w��
title('��Ⱥ��ʼ�ֲ�״̬ͼ');       

figure(2);
[r,c]=gradient(y0);
contour(x1,x2,y0);
hold on
quiver(x1,x2,r,c);
plot(xm(:,1),xm(:,2), 'k.');
title('��Ⱥ�ĵȸ����ݶȷֲ�ͼ');

figure(3);
mesh(x1, x2, y0);
hold on
plot3(xm(:,1),xm(:,2),f(xm(:,1),xm(:,2)), 'ro','MarkerFaceColor',[0 0 0],'MarkerSize',3);

iter = 1;                         % ��ʼ�ĵ���������Ϊ��while����Ϊ1
times = 1;                        % �۲���
record = zeros(ger, 1);              

%% ��������
while iter <= ger
    fx = f(x(:,1),x(:,2));               % ����x�еĶ�ά���ݣ�������嵱ǰ��Ӧ��,Ϊ500��1�е�����
    for i = 1:N                          % ��ÿһ���������ж�
        if fxm(i) < fx(i)                % ���ÿ���������ʷ�����Ӧ��С�ڸ��嵱ǰ��Ӧ��
            fxm(i) = fx(i);              % ���¸�����ʷ�����Ӧ��,��һ�־��ǰ�С��������
            xm(i,:) = x(i,:);            % ���¸�����ʷ���λ��
        end 
    end
     
    if fym < max(fxm)                    % ��Ⱥ��ʷ�����Ӧ��С�ڸ������������Ӧ�ȵ����ֵ
        [fym, nmax] = max(fxm);          % ����Ⱥ����ʷ�����Ӧ��,ȡ�������Ӧ�ȵ�ֵ������������λ��
        ym = xm(nmax, :);                % ����Ⱥ����ʷ���λ��
    end
    
    v = v * w + c1 * rand *(xm - x) + c2 * rand *(repmat(ym, N, 1) - x);    % �ٶȸ��¹�ʽ,repmat������ym���������N��2��
    
    
    for i=1:d
        for j=1:N
            if  v(j,i)>vlimit(i,2)       % ����ٶȴ��ڱ߽��ٶȣ�����ٶ����ر߽�
                v(j,i)=vlimit(i,2);
            end
            if  v(j,i) < vlimit(i,1)     % ����ٶ�С�ڱ߽��ٶȣ�����ٶ����ر߽�
                v(j,i)=vlimit(i,1);
            end
        end
    end
    
    x = x + v;                           % λ�ø���
    
    
    for i=1:d
        for j=1:N
            if  x(j,i)>plimit(i,2)
                x(j,i)=plimit(i,2);
            end
            if  x(j,i)<plimit(i,1)
                x(j,i)=plimit(i,1);
            end
        end
    end
    
    record(iter) = fym;                  % ��¼��ÿ�ε���Ⱥ������
    
    if times < 30                        % �����趨ϣ���۲�ĵ�������
        figure(3);
        cla;                             % �������ͼ��
        mesh(x1, x2, y0);
        plot3(xm(:,1),xm(:,2),f(xm(:,1),xm(:,2)), 'ro','MarkerFaceColor',[0 0 0],'MarkerSize',3);
        title('ǰ30��λ�õı仯״̬');
%         pause(0.5);                      % ��ִͣ��0.5�룬Ȼ�����ִ��
    end
    iter=iter+1;
    times=times+1;
end

%% ���ӻ�
figure(4);
plot(record);                         % �������ֵ�ı仯����
title('��������');


figure(5);
mesh(x1, x2, y0);
hold on;
plot3(x(:,1),x(:,2),f(x(:,1),x(:,2)), 'ro','MarkerFaceColor',[0 0 0],'MarkerSize',3);title('����λ�õ�״̬');

disp(['���ֵΪ��',num2str(fym)]);
disp(['���ֵ��λ�ã�',num2str(ym)]);
toc                                   % ��ʱ����