function reconstructed = BackProjection(sinogram)
    % Backprojection
    % INPUT
    %   Sinogram := 2NxN matrix of sinogram values (output of Radon
    %   Transform)
    %
    % OUTPUT
    %   For every pixel in the final NxN image, N lines at equally spaces
    %   angles are found that pass through it. The Radon Transform values
    %   for those line are found by interpolating.
    
    N = size(sinogram,2);
    [x, y] = meshgrid(linspace(0, pi, N), linspace(0, 2*N-1, 2*N));     
    the = linspace(0, pi, N);
    reconstructed = zeros(N);
    
    for i=1:N
        for j=1:N
            t_the = 2*(j-N/2)*cos(the)+2*(i-N/2)*sin(the)+N;
            % the "t" parameter for a line that passes through the point
            % (j-N/2, i-N/2) is found for each "theta". Here t is from 
            %[-N, N] instead of [-1, 1].
            weight = sqrt(1+(-2*(j-N/2)*sin(the)+2*(i-N/2)*cos(the)).^2);
            % adjusting for the arc length in order to take a line integral
            reconstructed(i, j) = sum(interp2(x, y, sinogram, the, t_the, 'linear').*weight)/sum(weight);
        end
    end
    
end