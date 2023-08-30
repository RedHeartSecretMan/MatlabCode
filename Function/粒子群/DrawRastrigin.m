function DrawRastrigin
x = -5:0.05:5;
y = x;
[X,Y] = meshgrid(x,y);
[r,c] = size(X);
for i = 1:r
    for j = 1:c
        Z(i,j) = Rastrigin([X(i,j),Y(i,j)]);
    end
end
surf(X,Y,Z);
shading interp
end