function [a1, b1, L1 ,L2 ,L3] = FindSidePoint(X)

bw = imbinarize(X);
register = bw;
v1 = 0;
v2 = 0;
v3 = 0;
v4 = 0;
a1 = 1;
a2 = 256;
b1 = 1;
b2 = 256;

[m ,n] = size(register);
for i = 1 : 1 : m
    for j = 1 : 1 : n
        if register(i ,j) == 0
            b1 = i;
            v1 = 1;
            break
        end
    end
    if v1 == 1
        break
    end
end
for i =  1 : 1 : n
    for j = 1 : 1 : m
        if register(j ,i) == 0
            a1 = i;
            v2 = 1;
            break
        end
    end
    if v2 == 1
        break
    end
end
for i = m : -1 : 1
    for j = n : -1 : 1
        if register(i ,j) == 0
            b2 = i;
            v3 = 1;
            break
        end
    end
    if v3 == 1
        break
    end
end
for i = n : -1 : 1
    for j = m : -1 : 1
        if register(j ,i) == 0
            a2 = i;
            v4 = 1;
            break
        end
    end
    if v4 == 1
        break
    end
end

L1 = a2-a1;
L2 = b2-b1;
L3 = max(L1, L2);

end