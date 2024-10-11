% Task B2: compute the filtered back projection

load('128_18.mat'); 
load('original_image_128.mat');
[numBeams, numAngles] = size(sino); % 185 beams x 18 projections
imageDimension = 128;
angles = linspace(10, 180, numAngles);
rect = linspace(-63, 64, imageDimension);
[x, y] = meshgrid(rect, rect);
final_grid = zeros(imageDimension, imageDimension); 

% filter
freq = linspace(-1, 1, numBeams)';
ramp_filter = abs(freq);

% filtering each column, before using same method as in A3
filtered_sino = zeros(size(sino));
for a = 1:numAngles
    proj_FFT = fftshift(fft(sino(:, a))); % computes the FFT  of the data at angle a, fftshift to center around 0 Hz
    % sino(:, a) is the projection data at angle a (a'th column)
    filtered_FFT = proj_FFT .* ramp_filter; % multiplying with ramp filter
    filtered_sino(:, a) = real(ifft(ifftshift(filtered_FFT))); % reversing the fft and fftshift, only taking real part
end

% back projection as done in A3
for a = 1:numAngles
    theta = deg2rad(angles(a));
    init_grid = zeros(imageDimension, imageDimension);
    for i = 1:imageDimension
        for j = 1:imageDimension
            l = x(i, j) * cos(theta) + y(i, j) * sin(theta); 
            l_index = round(l + (numBeams - 1) / 2); 
            if l_index >= 1 && l_index <= numBeams
                init_grid(i, j) = filtered_sino(l_index, a);
            end
        end
    end
    final_grid = init_grid + final_grid;
end


scaling = pi / (2 * numAngles);
result_image = final_grid * scaling;

control_image = iradon(sino, angles); % using matlab function to compare
control_image = control_image(2:end-1, 2:end-1); % removing first and last row/column

imagesc(rect, rect, control_image);  
colormap(winter); 
colorbar; 
axis equal;  
title('Inverse radon, PN = 18');
xlabel('x');
ylabel('y');


