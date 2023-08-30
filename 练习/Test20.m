fxy = Image2;
register1 = 0;
register2 = 0;

for r = 1 :size(fxy ,1)
    for c = 1 :size(fxy ,2)
        register1 = register1 + double(fxy(r ,c))^2;
        register2 = register2 + double(fxy(r ,c));
    end
end

N = size(fxy ,1)*size(fxy ,2);
C539_2 = sqrt((register1/N)-((register2/N)^2))/(register2/N);