function p=lap(im,N)
    if nargin==1, N=5; end
    %N-1 niveles de detalle y 1 reducida
    im=im2double(im);
    p=cell(1,N);

    % Hacemos bucle
    for k = 1:N-1
        F = 2;
        red=imresize(im,1/F);
        im2 = imresize(red,F);
        p{k}=im-im2;
        im = red;
    end
    p{N}=red;
return