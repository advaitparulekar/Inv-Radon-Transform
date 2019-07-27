function transform = Filter(Radon_t)
    % Hilbert Transform
    % INPUT
    %   Radon_t := output of Radon Transform
    % OUTPUT
    %   transform := filtered Radon_transform (ramp filter)

    N = size(Radon_t, 2);
    y = [0:1:2*N-1]'*ones(1, N);
    % create a matrix of the form
    % 0 0 ... 0
    % 1 1 ... 1
    % . .
    % .   .
    % .     .
    % 2*N-1 2*N-1 ... 2*N-1
    
    fR = fft(Radon_t);
    filtered_fR = fR.*min(y, 2*N-y)*pi;
    % filter by multiplying fourier transform with |w| = min(y, 2*N-y)
    transform = ifft(filtered_fR);
end