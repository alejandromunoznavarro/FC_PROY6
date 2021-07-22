clear;
clc;

load keypoints;
NF = 12;

xy1=[200 400 600 300 500; 375 125 375 200 200]'
xy2=[ 87 319 600 200 450; 445 69 375 185 155]';

P=get_proy(xy1,xy2);

H = [xy1';xy1(:,1)'.^0];

uv = P*H;
u=floor(uv(1,:)./uv(3,:))
v=floor(uv(2,:)./uv(3,:))

err=error_ajuste(P,xy1,xy2)