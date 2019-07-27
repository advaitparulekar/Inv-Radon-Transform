function final_reconstruction = Reconstruction(image, N)
    % INPUT
    %   image := NxN matrix of image grayscale values.
    %
    % OUTPUT
    %   reconstructed image, ready for imshow()
    Radon_t = zeros(2*N, N);

    for i=0:2*N-1
        for j = 0:N-1
            Radon_t(i+1, j+1) = Radon(image, (i-N)/N, j*pi/N);
        end
    end
    
    filtered_sinogram = Filter(Radon_t);
    final_reconstruction = BackProjection(filtered_sinogram);
end