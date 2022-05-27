function [ mifft2 ] = Ifft2Iterative( data )
    h = size(data, 1);
    w = size(data, 2);
    mifft2 = data;

    if power(2, log2(h)) ~= h || power(2, log2(w)) ~= w
        disp('exit: h and w must be the power of 2!')
    else
        for i = 1 : h
            mifft2(i, :) = IfftIterative(mifft2(i, :));
        end

        for j = 1 : w
            mifft2(:, j) = IfftIterative(mifft2(:, j));
        end
    end
end

function [ ifft_m ] = IfftIterative( vec )
    clear i;
    n = length(vec);
    ifft_m = BitReverseCopy(vec);
    for s = 1 : log2(n)
        m = power(2, s);
        wm = exp(2 * pi * i / m);

        for k = 0 : m : n - 1
            w = 1;
            for j = 0 : m / 2 - 1
                t = w * ifft_m(k + j + m / 2 + 1);
                u = ifft_m(k + j + 1);
                ifft_m(k + j + 1) = u + t;
                ifft_m(k + j + m / 2 + 1) = u - t;
                w = w * wm;
            end
        end
    end
    ifft_m = ifft_m ./ n;
end

function [ copy ] = BitReverseCopy( vec )
    n = length(vec);
    copy = zeros(1, n);
    bitn = log2(n);
    for i = 0 : n - 1
        revi = bin2dec(fliplr(dec2bin(i, bitn)));
        copy(revi + 1) = vec(i + 1);
    end
end