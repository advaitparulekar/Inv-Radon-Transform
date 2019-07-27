function plot_profile(pixels, reconstructed_image, original_image, t, theta)
    [x, y] = meshgrid(linspace(-1, 1, pixels), linspace(-1, 1, pixels));
    
    x1 = cos(theta+acos(t));
    y1 = sin(theta+acos(t));
    x2 = cos(theta-acos(t));
    y2 = sin(theta-acos(t));

    xq = linspace(x1, x2, 100);
    yq = linspace(y1, y2, 100);

    r_true_profile = interp2(x, y, original_image(:, :, 1), xq, yq, 'linear');
    r_re_profile = interp2(x, y, reconstructed_image(:, :, 1), xq, yq, 'linear');
    g_true_profile = interp2(x, y, original_image(:, :, 2), xq, yq, 'linear');
    g_re_profile = interp2(x, y, reconstructed_image(:, :, 2), xq, yq, 'linear');
    b_true_profile = interp2(x, y, original_image(:, :, 3), xq, yq, 'linear');
    b_re_profile = interp2(x, y, reconstructed_image(:, :, 3), xq, yq, 'linear');
    figure;
    subplot(3, 1, 1); plot(r_true_profile);
    hold on;
    subplot(3, 1, 1); plot(r_re_profile);
    subplot(3, 1, 2); plot(g_true_profile);
    hold on;
    subplot(3, 1, 2); plot(g_re_profile);
    subplot(3, 1, 3); plot(b_true_profile);
    hold on;
    subplot(3, 1, 3); plot(b_re_profile);
end