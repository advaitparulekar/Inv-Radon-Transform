function P = phantom(x, y, r, densities, pixels)
    N = length(x);
    P = zeros(pixels);
    for i = 1:pixels
        for j = 1:pixels
            for k = 1:N    
                % check if pixel is inside the circle, and add density at
                % pixel
                if((2*i/pixels-1-y(k))^2+(2*j/pixels-1-x(k))^2 < r(k)^2)
                    P(i, j) = P(i, j)+densities(k);
                end
            end
        end
    end
end