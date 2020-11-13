I = imread('Test Image/test_im1.jpg'); 
I2 = I.*0.3;
I3 = I.*2;
grayIm1 = rgb2gray(I);
grayIm2 = rgb2gray(I2);
grayIm3 = rgb2gray(I3);

%Определение яркости 
Ymax = 255;
Y1 = mean2(grayIm1);
brightness1 = Y1 / Ymax;
Y2 = mean2(grayIm2);
brightness2 = Y2 / Ymax;
Y3 = mean2(grayIm3);
brightness3 = Y3 / Ymax;
%Определение яркостной контрастности
sigma1 = mean2((grayIm1 - Y1).^2);
bright_contrast1 = 2 * sqrt(sigma1) / Ymax;
sigma2 = mean2((grayIm2 - Y2).^2);
bright_contrast2 = 2 * sqrt(sigma2) / Ymax;
sigma3 = mean2((grayIm3 - Y3).^2);
bright_contrast3 = 2 * sqrt(sigma3) / Ymax;
%Определение тоновой контрастности
r = I(:,:,1);
g = I(:,:,2);
b = I(:,:,3);
R = mean2(r);
G = mean2(g);
B = mean2(b);

r2 = I2(:,:,1);
g2 = I2(:,:,2);
b2 = I2(:,:,3);
R2 = mean2(r2);
G2 = mean2(g2);
B2 = mean2(b2);

r3 = I3(:,:,1);
g3 = I3(:,:,2);
b3 = I3(:,:,3);
R3 = mean2(r3);
G3 = mean2(g3);
B3 = mean2(b3);

dmax = sqrt(3) * 255;
d_p1 = sqrt(double((r-R).^2 + (g-G).^2 + (b-B).^2));
d1 = mean2(d_p1);
tone_contrast1 = d1 / dmax;
d_p2 = sqrt(double((r2-R2).^2 + (g2-G2).^2 + (b2-B2).^2));
d2 = mean2(d_p2);
tone_contrast2 = d2 / dmax;
d_p3 = sqrt(double((r3-R3).^2 + (g3-G3).^2 + (b3-B3).^2));
d3 = mean2(d_p3);
tone_contrast3 = d3 / dmax;

M=800;
subplot(2,3,1);
imshow(I);
text(4,M+30,strcat('brightness = ',num2str(brightness1)));
text(4,M+90,strcat('bright contrast = ',num2str(bright_contrast1)));
text(4,M+150,strcat('tone contrast = ',num2str(tone_contrast1)));

subplot(2,3,2);
imshow(I2);
text(4,M+30,strcat('brightness = ',num2str(brightness2)));
text(4,M+90,strcat('bright contrast = ',num2str(bright_contrast2)));
text(4,M+150,strcat('tone contrast = ',num2str(tone_contrast2)));

subplot(2,3,3);
imshow(I3);
text(4,M+30,strcat('brightness = ',num2str(brightness3)));
text(4,M+90,strcat('bright contrast = ',num2str(bright_contrast3)));
text(4,M+150,strcat('tone contrast = ',num2str(tone_contrast3)));

