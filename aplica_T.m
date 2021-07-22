function im2 = aplica_T(im,P,RU,RV)
if nargin<4, RV=(1:size(im,1)); RU=(1:size(im,2)); end
  
    im = im2double(im);
    N = length(RV);
    M = length(RU);
    im2 = zeros(N, M, 3);
    X = zeros(N,M);
    Y = zeros(N,M);
    
    for k = 1:N
%         for j = 1:M
%            u = RU(j);
%            v = RV(k);
           u = RU;
           v = (u.^0)*RV(k);
           uv = [u; v; u.^0];
           uv = P\uv;
           x = uv(1,:)./uv(3,:);
           y = uv(2,:)./uv(3,:);
           X(k,:) = x(:);
           Y(k,:) = y(:);
%            X(k,j) = x;
%            Y(k,j) = y;
%         end
    end
    
    for k = 1:3
        im2(:,:,k) = interp2(im(:,:,k),X,Y,'bilinear');
    end
%     im2 = uint8(im2*255);
return


