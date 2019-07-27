N=128;
% number of samples

rgb = input('RGB?', 's');

if isempty(rgb)
    % if empty, grayscale
    RGB = imread('fatDot.png');
    imshow(RGB);
    grayscale_image = rgb2gray(RGB);
    image = 1-im2double(imresize(grayscale_image, [N, N]));
    reconstructed = Reconstruction(image, N);
    imshow(reconstructed)
else
    % do the same as above to each of the RGB conponents and then put them
    % back together for final color image
    RGB = imread('RGB_image.png');
    imshow(RGB);
    r_image = im2double(imresize(RGB(:, :, 1), [N, N]));
    g_image = im2double(imresize(RGB(:, :, 2), [N, N]));
    b_image = im2double(imresize(RGB(:, :, 3), [N, N]));

    rgb_reconstructed = zeros(N, N, 3);

    rgb_reconstructed(:, :, 1) = Reconstruction(r_image, N);
    rgb_reconstructed(:, :, 2) = Reconstruction(g_image, N);
    rgb_reconstructed(:, :, 3) = Reconstruction(b_image, N);
    figure;
    imshow(rgb_reconstructed);
end