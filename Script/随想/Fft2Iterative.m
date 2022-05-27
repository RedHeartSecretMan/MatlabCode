function [ mfft2 ] = Fft2Iterative( data )
    h = size(data, 1);
    w = size(data, 2);
    mfft2 = data;

    if power(2, log2(h)) ~= h || power(2, log2(w)) ~= w
        disp('exit: h and w must be the power of 2!')
    else
        for i = 1 : h
            mfft2(i, :) = FftIterative(mfft2(i, :));
        end

        for j = 1 : w
            mfft2(:, j) = FftIterative(mfft2(:, j));
        end
    end
end

function [ fft_m ] = FftIterative( vec )
    clear i;
    n = length(vec);
    fft_m = BitReverseCopy(vec);
    for s = 1 : log2(n)
        m = power(2, s);
        wm = exp(- 2 * pi * i / m);
        for k = 0 : m : n - 1
            w = 1;
            for j = 0 : m / 2 - 1
                t = w * fft_m(k + j + m / 2 + 1);
                u = fft_m(k + j + 1);
                fft_m(k + j + 1) = u + t;
                fft_m(k + j + m / 2 + 1) = u - t;
                w = w * wm;
            end
        end
    end
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