clear;
clc;

NF = 12;
name='fc_torre';
load keypoints;
load QP_data;
T=enlaza(Q,P);
u_min=1;
u_max=900;
v_min=1;
v_max=600;

for k = 1:NF
    fich  = sprintf('%s%02d.jpg',name,k);
    im = imread(fich);
    P=T{k};
    [RU,RV]=rango_uv(size(im),P);
    if(RU(1)<u_min)
        u_min=RU(1);
    end
    if(RU(end)>u_max)
        u_max=RU(end);
    end
    if(RV(1)<v_min)
        v_min=RV(1);
    end
    if(RV(end)>v_max)
        v_max=RV(end);
    end
end
dU=(1-u_min);
dV=(1-v_min);
u_min = u_min+dU;
u_max = u_max+dU;
v_min = v_min+dV;
v_max = v_max+dV;
ANCHO = u_max;
ALTO = v_max;

M = [1 0 dU; 0 1 dV; 0 0 1];
mosaico = zeros(ALTO,ANCHO,3);
for k = 1:NF
    T{k} = M*T{k};
    fich  = sprintf('%s%02d.jpg',name,k);
    im = im2double(imread(fich));
    P=T{k};
    [RU,RV]=rango_uv(size(im),P);
    
    im2 = aplica_T(im,P,RU,RV);
    A=~isnan(im2(:,:,:));

    %  Reducir para mejorar la velocidad del programa   
    for i=1:size(im2,1)
        for j=1:size(im2,2)
            if(A(i,j,:))
                mosaico(RV(i),RU(j),:)=im2(i,j,:);
            end
        end
    end 
end
imshow(uint8(mosaico*255));

recortada = imcrop(mosaico);
imshow(uint8(recortada*255));
