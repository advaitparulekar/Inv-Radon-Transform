function integral = Radon(image, t, theta)
    % Radon Transform
    % INPUT
    %   image   := NxN matrix containing image grayscale values
    %   t       := distance of the closest point on the line to the origin
    %   theta   := angle of normal
    %   N       := size of image
    %
    % OUTPUT
    %   integral of density along the line parameterized by t, theta, i.e.
    %   the line dot((x, y),(cos(theta), sin(theta))) = t
    
    N = length(image);
    [X, Y] = meshgrid(linspace(-1, 1, N), linspace(-1, 1, N));
    % embed the image in an NxN grid with coordinates [-1, 1]

    X1 = cos(theta+acos(t));
    Y1 = sin(theta+acos(t));
    X2 = cos(theta-acos(t));
    Y2 = sin(theta-acos(t));
    % to simplify, we just consider the region inside a circle of radius
    % one. (X1, Y1) and (X2, Y2) denote the points of intersection of a
    % line with normal angle "theta" and distance "t" from the center.
    
    dist = sqrt((X1-X2)^2+(Y1-Y2)^2);

    Xq = linspace(X1, X2, 100);
    Yq = linspace(Y1, Y2, 100);

    integral = sum(interp2(X, Y, image, Xq, Yq, 'linear'))*dist/100;
end

