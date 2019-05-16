% Create image with Gaussian noise
I = imread('cameraman.tif');
I_noise = imnoise(I,'gaussian', 0, 0.3);
figure(1);imshow(I_noise);

% Initialize paremeters for this experiment
stepsize = 0.02;
iteration = 100;
lambda = 0.0002;
epsilon = 0.0001;

% Initialize target images and pre-process source image
%TV = sqrt(gradI_x.^2 + gradI_y.^2);
v = double(I_noise);
u = zeros(size(I_noise));
energyFunction = zeros(100);

for k = 1:iteration
    % Use central difference to calculate gradient term
   ux = Dx(v)./2 + Dxt(v)./2;
   uy = Dx(v)./2 + Dxt(v)./2;
   
   % Use backward difference
   %ux = Dx(v);
   %uy = Dx(v);
   
   % Calculate gradient
   gradient = sqrt(ux.^2 + uy.^2);
   
   % Use central difference
   uxx = Dx(ux)./2 + Dxt(ux)./2;
   uyy = Dx(uy)./2 + Dxt(uy)./2;
   
   % Use backward difference
   %uxx = Dx(ux);
   %uyy = Dx(uy);
   
   div = uxx + uyy;
   
   % Calculate the gradient fo the image
   gradient = (u - v) - lambda * div./(gradient + epsilon);
   
   % Calcualte the energy
   energy = norm(u - v,2) + norm(gradient,2);
   
   % Use gradient descent to update new images
   u = u - gradient * stepsize;
   
   % Store every value of energy into the energy function
   energyFunction(k) = energy;
   
end

% Plot graph of energy function
%plot(energyFunction);

% Plot denoised image
figure(2);imshow(u,[]);