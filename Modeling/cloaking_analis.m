I1 = imread('original_p2.jpg');
origIm = rgb2gray(I1);
subplot(1,2,1);
imshow(origIm);

I2 = imread('cloak_p2.jpg');
cloakIm = rgb2gray(I2);
subplot(1,2,2);
imshow(cloakIm);


[M,N] = size(origIm);
[x, y]=meshgrid(1:N,1:M);
im_diff = cloakIm-origIm;
imshow(im_diff*100);
%mesh(x,y, abs(im_diff));


%h1=fft2(origIm);
%imagesc(abs(fftshift(h1)))
%subplot(1,2,1);
%mesh(x,y, abs(fftshift(h1)));

%h2=fft2(cloakIm);
%imagesc(abs(fftshift(h2)))
%subplot(1,2,2);
%mesh(x,y, abs(fftshift(h2)));





