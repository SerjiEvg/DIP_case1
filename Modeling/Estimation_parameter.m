I = imread('leo1.jpg');
origIm = rgb2gray(I);
h1=fft2(origIm);
[M,N] = size(origIm);

sigma = 10;
gaussian = imfilter(origIm, fspecial('gaussian',[5 5], sigma));
h2=fft2(gaussian);
littleBlurredIm = imfilter(origIm, fspecial('motion',17,45),'replicate');
h3=fft2(littleBlurredIm);


ITER_T = 0;
RESULT(:,:) = 0.0;
for n=1:10000
    m1 = max(max(abs(h1)))*ITER_T;
    m2 = max(max(abs(h2)))*ITER_T;
    m3 = max(max(abs(h3)))*ITER_T;
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
    
    RESULT(1,n) = ITER_T;
    RESULT(2,n) = Image_Quality_1;
    RESULT(3,n) = Image_Quality_2;
    RESULT(4,n) = Image_Quality_3;
    ITER_T = ITER_T+0.000001
end
subplot(1,1,1);
semilogx(RESULT(1,:),RESULT(2,:),'.-r');
hold on;
grid on;
semilogx(RESULT(1,:),RESULT(3,:),'*-g');
semilogx(RESULT(1,:),RESULT(4,:),'o-b');
save 'E:\REPOS\DIP_case1\Analisys reseach\experiments\RESULT_leo1_sigma_10_motion_17_45.mat' RESULT -ascii -tabs;
%clear all;













