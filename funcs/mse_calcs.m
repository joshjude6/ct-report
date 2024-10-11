% MSE calculations
load('original_image_128.mat'); 

% MSE calculations for task C
% image files from each task is called result_image_tasknumber_pn

mse_a3_18 = immse(result_image_a3_18, original_image); % back projection
mse_b2_18 = immse(result_image_b2_18, original_image); % fbp
mse_c2_18 = immse(result_image_c2_18, original_image); % matlab iradon 
disp(['MSE for A3 - PN = 18: ' num2str(mse_a3_18)]);
disp(['MSE for B2 - PN = 18: ' num2str(mse_b2_18)]);
disp(['MSE for C2 - PN = 18: ' num2str(mse_C2)_18]);

mse_a3_60 = immse(result_image_a3_60, original_image); % back projection
mse_b2_60 = immse(result_image_b2_60, original_image); % fbp
mse_c2_60 = immse(result_image_c2_60, original_image); % matlab iradon 
disp(['MSE for A3 - PN = 60: ' num2str(mse_a3_60)]);
disp(['MSE for B2 - PN = 60: ' num2str(mse_b2_60)]);
disp(['MSE for C2 - PN = 60: ' num2str(mse_c2_60)]);

% MSE calculations for task E

MSE_low = zeros(1, 10);
MSE_none = zeros(1, 10);
MSE_high = zeros(1, 10);

for N = 1:10
    filename = sprintf('low_60_N=%d.mat', N); 
    load(filename); 
    MSE_low(N) = immse(result_image, original_image); 
end

for N = 1:10
    filename = sprintf('none_60_N=%d.mat', N); 
    load(filename); 
    MSE_none(N) = immse(result_image, original_image);
end

for N = 1:10
    filename = sprintf('high_60_N=%d.mat', N);
    load(filename);
    MSE_high(N) = immse(result_image, original_image);
end

for N = 1:10
    filename = sprintf('128_60_N=%d.mat', N);
    load(filename); 
    MSE_reg(N) = immse(result_image, original_image);
end

save('MSE_comparison_values.mat', 'MSE_low', 'MSE_none', 'MSE_high', 'MSE_reg');

% plotting of the different relaxation factors
iterations = 1:10;
figure;
plot(iterations, MSE_low, '-o', 'DisplayName', '\lambda = 0.1');
hold on;
plot(iterations, MSE_reg, '-p', 'DisplayName', '\lambda = 0.5');
plot(iterations, MSE_none, '-s', 'DisplayName', '\lambda = 1');
plot(iterations, MSE_high, '-d', 'DisplayName', '\lambda = 1.25');
xlabel('Iterations (N)');
ylabel('MSE');
title('MSE comparison for different relaxation factors');
legend('show');
grid on;



