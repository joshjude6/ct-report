% Task A3: compute back projection summation image

load('128_60.mat');
load('original_image_128.mat');
[num_beams, num_angles] = size(sino); % 185 x 18
imageDimension = 128;
angles = linspace(10, 180, num_angles);
rect = linspace(-63, 64, imageDimension); % object axis
[x, y] = meshgrid(rect, rect);
final_grid = zeros(imageDimension, imageDimension); % init summed empty grid


for a = 1:num_angles
    theta = deg2rad(angles(a)); % same method as A2, but need to iterate over every angle
    init_grid = zeros(imageDimension, imageDimension);
    for i = 1:imageDimension
        for j = 1:imageDimension
            l = x(i, j)*cos(theta) + y(i, j)*sin(theta); 
            l_index = round(l + (num_beams - 1) / 2); 
            if l_index >= 1 && l_index <= num_beams
                init_grid(i, j) = sino(l_index, a);
            end
        end
    end
    final_grid = init_grid + final_grid;
end

scaling = pi / (2 * numAngles);
result_image = final_grid * scaling;

imagesc(rect, rect, result_image);  
colormap(winter); 
colorbar; 
axis equal;  
title('Summed back projection, PN = 60');
xlabel('x');
ylabel('y');
