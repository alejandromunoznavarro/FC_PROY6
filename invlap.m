function im=invlap(p)
    N = length(p); % Número de níveles de la piramide
    im = p{N};
    for k = N-1:-1:1
        F = 2;
        im=imresize(im,F);
        im = im+p{k};
    end
%     im = uint8(im*255);
end