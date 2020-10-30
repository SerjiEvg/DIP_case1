I = imread('leo1.jpg'); 
grayIm = rgb2gray(I);
[M,N] = size(grayIm);
%Определение яркости 
Ymax1 = double(max(max(grayIm)));
Y1 = mean2(grayIm);
brightness1 = Y1 / Ymax1;
%Определение яркостной контрастности
sigma1 = mean2((grayIm - Y1).^2);
bright_contrast1 = 2 * sqrt(sigma1) / Ymax1;
%Определение тоновой контрастности
r = I(:,:,1);
g = I(:,:,2);
b = I(:,:,3);
R = mean2(r);
G = mean2(g);
B = mean2(b);
d_p = sqrt(double((r-R).^2 + (g-G).^2 + (b-B).^2));
dmax = sqrt(3) * double(max(max(r)));
d = mean2(d_p);
tone_contrast = d / dmax;

subplot(2,3,1);
imshow(I);
text(4,M+30,strcat('brightness = ',num2str(brightness1)));
text(4,M+90,strcat('bright contrast = ',num2str(bright_contrast1)));
text(4,M+150,strcat('tone contrast = ',num2str(tone_contrast)));
