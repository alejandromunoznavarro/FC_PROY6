clear;
clc;

name='fc_torre';
NF = 12;
s = cell(1,NF);
for k = 1:NF
    fich  = sprintf('%s%02d.jpg',name,k);
    im = imread(fich);
    imshow(im);
    bw = rgb2gray(im);
    imwrite(bw,'bw.pgm');
    system('siftWin32 <bw.pgm >data.txt');
    s{k} = fc_info_puntos('data.txt');
end

im = imread('fc_torre05.jpg');
imshow(im);
hold on
title('foto05.jpg')
plot(s{5}.xy(:,1),s{5}.xy(:,2),'ro')

save keypoints s