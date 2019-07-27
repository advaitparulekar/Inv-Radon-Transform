RGB = imread('fatDot.png');
imshow(RGB);

grayscale_image = rgb2gray(RGB);

imshow(grayscale_image);

N=128;
T = 64;

down_gray = 1-im2double(imresize(grayscale_image, [N, N]));

imshow(down_gray);

Radon_t = zeros(2*N, N);

for i=0:2*N-1
    for j = 0:N-1
        Radon_t(i+1, j+1) = Radon(down_gray, (i-N)/N, j*pi/N, N);
    end
end

imshow(atan(20*Radon_t)*2/pi);
pause;

fR = zeros(2*N, N);

for i=1:N
   fR(:, i) = fft(Radon_t(:, i)); 
end

imshow(fR);


[x, y] = meshgrid(linspace(0, pi, N), linspace(0, 2*N-1, 2*N));

the = linspace(0, pi, N);
reconstructed_image_blur = zeros(N);
for i=1:N
    for j=1:N
        t_the = 2*(j-N/2)*cos(the)+2*(i-N/2)*sin(the)+N;
        reconstructed_image_blur(i, j) = sum(interp2(x, y, Radon_t, the, t_the, 'linear'))*pi/N;
    end
end
imshow(reconstructed_image_blur);
%imshow(atan(0.2*reconstructed_image_blur)*2/pi);
pause;

filtered_fR = fR.*min(y, 2*N-y)*pi;

fourier_filtered_fR = zeros(2*N, N);

for i=1:N
   fourier_filtered_fR(:, i) = ifft(filtered_fR(:, i)); 
end
figure;
imshow(fourier_filtered_fR);
pause;


reconstructed_image = zeros(N);
for i=1:N
    for j=1:N
        t_the = 2*(j-N/2)*cos(the)+2*(i-N/2)*sin(the)+N;
        reconstructed_image(i, j) = sum(interp2(x, y, fourier_filtered_fR, the, t_the, 'linear'))*pi/N;
    end
end

figure;
imshow(reconstructed_image)
% 
% [x, y] = meshgrid(linspace(-N, N, 2*N), linspace(-N, N, 2*N));
% 
% xq = atan(y./x)+pi;
% yq = -(x.^2+y.^2).^0.5.*sign(x)+N;
% 
% [fR_x, fR_y] = meshgrid(linspace(0, 2*pi, N), linspace(0, 2*N, 2*N));
% 
% polar_fR = interp2(fR_x, fR_y, fR, xq, yq, 'linear');
% 
% imshow(polar_fR);
% 
% filtered_polar_fR = polar_fR.*sqrt((N-x).^2+(N-y).^2);
% 
% imshow(ifft2(filtered_polar_fR));