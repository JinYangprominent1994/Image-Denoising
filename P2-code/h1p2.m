% read source image with noise
I = imread('lenaNoise.png');

% show source image
figure(1);imshow(I);title('source image');

% use fft2 function to compute fourier transform
F = fft2(I);

% use fftshift to center the low frequency
FS = fftshift(F);

% show centered fourier transform of image
figure(2);imshow(FS);title('centered fourier transform of image');

% initialize a blank new image
blank = zeros(512,512);

% keep different number of low frequencies
size = 240;

% locate the center of image
square = FS(size:512 - size/2 + 1,size:512 - size/2 +1);
blank(size:512 -size/2 + 1,size:512 - size/2 + 1) = square;

% use ifftshift function to relocate the center of image
FSF = ifftshift(blank);

% use ifft2 function to reconstruct the original image
new = ifft2(FSF);

% show reconstructed image
figure(3);imshow(new,[]);title('reconstructed Imgae');
