% Task A2: compute back projection at 30 degrees

load('128_18.mat'); %
[num_beams, num_angles] = size(sino); % 185 x 18
imageDimension = 128;

angles = linspace(10, 180, num_angles);
% loop to ensure correct angle calculation for different files
if num_angles == 18
    angle_index = find(angles == 30);
else
    [~, angle_index] = min(abs(angles - 30)); % no exact index corresponding to 30 in the 60 sinogram, 
    % need to round off like this to find the closest index to 30 degrees
end

rect = linspace(-63, 64, imageDimension); % object axis
[x, y] = meshgrid(rect, rect); % x and y coords for every image pixel

final_grid = zeros(imageDimension, imageDimension); % init empty grid to map projections onto
theta = deg2rad(30);

for i = 1:imageDimension
    for j = 1:imageDimension
        l = x(i, j)*cos(theta) + y(i, j)*sin(theta); % projection line calculation
        l_index = round(l + (num_beams - 1) / 2); % accounting for the fact that -92 <= l <= 92
        if l_index >= 1 && l_index <= num_beams % to avoid incompatible indexes being mapped
            final_grid(i, j) = sino(l_index, angle_index); % mapping corresponding sinogram value onto image pixel
        end
    end
end

imagesc(rect, rect, final_grid);  
colormap(winter);  
colorbar;  
axis equal;  
title('Back projection at 30 degrees, PN = 60');
xlabel('x');
ylabel('y');
