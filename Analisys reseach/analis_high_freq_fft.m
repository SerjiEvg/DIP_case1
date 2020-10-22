I = imread('leo1.jpg');
origIm = rgb2gray(I);
subplot(2,3,1);
imshow(origIm);
%Применение фильтров
sigma = 2;
gaussian = imfilter(origIm, fspecial('gaussian',[5 5], sigma));
littleBlurredIm = imfilter(origIm, fspecial('motion',5,45),'replicate');
muchBlurredIm = imfilter(origIm, fspecial('motion',20,45),'replicate');
subplot(2,3,2);
imshow(gaussian);
subplot(2,3,3);
imshow(muchBlurredIm);
%Спектральная составляющая
[M,N] = size(origIm);
[x, y]=meshgrid(1:N,1:M);
h1=fft2(origIm);
subplot(2,3,4);
%imagesc(angle(fftshift(h1)));
%imagesc(abs(fftshift(h1)));
%colormap(gray);
mesh(x,y, abs(fftshift(h1)));
zlim([5E+3 inf]);
h2=fft2(gaussian);
subplot(2,3,5);
%imagesc(angle(fftshift(h2)));
%imagesc(abs(fftshift(h2)));
%colormap(gray);
mesh(x,y, abs(fftshift(h2)));
zlim([5E+3 inf]);
h3=fft2(littleBlurredIm);
subplot(2,3,6);
mesh(x,y, abs(fftshift(h3)));
zlim([5E+3 inf]);
%imagesc(angle(fftshift(h3)));
%imagesc(abs(fftshift(h3)));
%colormap(gray);
%imagesc(angle(h));
%imagesc(arg(fftshift(h)));
%[M,N] = size(h);
%[x, y]=meshgrid(1:N,1:M);
%mesh(x,y, angle(h));
%Вычисление меры
m1 = max(max(abs(h1)))/10000;
m2 = max(max(abs(h2)))/10000;
m3 = max(max(abs(h3)))/10000;

k1=0;
k2=0;
k3=0;
for i = 1 : M
   for j = 1: N 
       if(h1(i,j)>=m1) 
         k1 = k1 + 1;
       end 
       if(h2(i,j)>=m2) 
         k2 = k2 + 1; 
       end 
       if(h3(i,j)>=m3) 
         k3 = k3 + 1; 
       end     
   end
end
Image_Quality_1 = k1/(M*N);
Image_Quality_2 = k2/(M*N);
Image_Quality_3 = k3/(M*N);
hold on
subplot(2,3,1);
if(Image_Quality_1 > 0.2)  
   text(4,M+30,'best image', 'Color', 'g');
else
   text(4,M+30,'bad image', 'Color', 'r');
end
subplot(2,3,2);
if(Image_Quality_2 > 0.2)  
   text(4,M+30,'best image', 'Color', 'g');
else
   text(4,M+30,'bad image', 'Color', 'r');  
end
subplot(2,3,3);
if(Image_Quality_3 > 0.2)  
   text(4,M+30,'best image', 'Color', 'g');
else
   text(4,M+30,'bad image', 'Color', 'r');
end
hold off;



