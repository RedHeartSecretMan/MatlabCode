function c = fitness(a,b)
% c = (a .* sin(a) .* cos(2 * a) - 2 * a .* sin(3 * a)).*(b .* sin(b) .* cos(2 * b) - 2 * b .* sin(3 * b));
c = (a .* sin(a) .* cos(2 * a) - 2 * a .* sin(3 * a)).*(b .* sin(b) .* cos(2 * b) - 2 * b .* sin(3 * b));   
% c = (a .* sin(a) .* exp(b) .* cos(2 * a) .* exp(2 * b) - 2 * a .* sin(3 * a) .* cos(3 * b));
end