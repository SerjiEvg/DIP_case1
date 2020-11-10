%Отображение исходного изображения
I = imread('TestImage/test_im1.jpg');
origIm = rgb2gray(I);
subplot(1,1,1);
imshow(origIm);
pause;
%Отображение изображения с радиальным размытием
sigma = 4;
gaussian = imfilter(origIm, fspecial('gaussian',[30 30], sigma));
subplot(1,1,1);
imshow(gaussian);
pause;
%Отображение изображения с имитацией движения
littleBlurredIm = imfilter(origIm, fspecial('motion',20,0),'replicate');
subplot(1,1,1);
imshow(littleBlurredIm);
pause;
%вычисление спектров изображений
[M,N] = size(origIm);
[x, y]=meshgrid(1:N,1:M);
h1=fft2(origIm);
h2=fft2(gaussian);
h3=fft2(littleBlurredIm);
%Вычисление диапазона значений
a1 = h1(1,1)/(M*N);
a2 = h2(1,1)/(M*N);
a3 = h3(1,1)/(M*N);
Tim = 0.00015;
%Спектр исходного изображения
subplot(1,1,1);
mesh(x,y, abs(fftshift(h1)));
zlim([a1*Tim*(M*N) inf]);
xlim([0 M]);
ylim([0 N]);
pause;
%Спектр размытого изображения
subplot(1,1,1);
mesh(x,y, abs(fftshift(h2)));
zlim([a2*Tim*(M*N) inf]);
xlim([0 M]);
ylim([0 N]);
pause;
%Спектр изображения в движении
subplot(1,1,1);
mesh(x,y, abs(fftshift(h3)));
zlim([a3*Tim*(M*N) inf]);
xlim([0 M]);
ylim([0 N]);

pause;
%фазовый спект исходного изображения
subplot(1,1,1);
imagesc(angle(fftshift(h1)));
%colormap(gray);
pause;
%фазовый спект 
subplot(1,1,1);
imagesc(angle(fftshift(h2)));
%colormap(gray);
pause;
%фазовый спект изображения в движении
subplot(1,1,1);
imagesc(angle(fftshift(h3)));
%colormap(gray);



%imagesc(angle(fftshift(h1)));
%imagesc(abs(fftshift(h1)));
%colormap(gray);
%subplot(2,3,5);
%imagesc(angle(fftshift(h2)));
%imagesc(abs(fftshift(h2)));
%colormap(gray);
%mesh(x,y, abs(fftshift(h2)));
%zlim([5E+3 inf]);

%subplot(2,3,6);
%mesh(x,y, abs(fftshift(h3)));
%zlim([5E+3 inf]);
%imagesc(angle(fftshift(h3)));
%imagesc(abs(fftshift(h3)));
%colormap(gray);
%imagesc(angle(h));
%imagesc(arg(fftshift(h)));
%[M,N] = size(h);
%[x, y]=meshgrid(1:N,1:M);
%mesh(x,y, angle(h));
%Вычисление меры

m1 = max(max(abs(h1)))*Tim/a1;
m2 = max(max(abs(h2)))*Tim/a2;
m3 = max(max(abs(h3)))*Tim/a3;

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
%hold on
%subplot(2,3,1);
%if(Image_Quality_1 > 0.2)  
%   text(4,M+30,'best image', 'Color', 'g');
%else
%   text(4,M+30,'bad image', 'Color', 'r');
%end
%subplot(2,3,2);
%if(Image_Quality_2 > 0.2)  
%   text(4,M+30,'best image', 'Color', 'g');
%else
%   text(4,M+30,'bad image', 'Color', 'r');  
%end
%subplot(2,3,3);
%if(Image_Quality_3 > 0.2)  
%   text(4,M+30,'best image', 'Color', 'g');
%else
%   text(4,M+30,'bad image', 'Color', 'r');
%end
%hold off;






