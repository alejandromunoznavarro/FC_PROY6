function P=get_proy(xy,uv)
% xy,uv: matrices Nx2 (N>=3) con coordenadas de origen(xy) y destino(uv)
% P matriz 3x3 con la transformación proyectiva.
    A = [xy(:,1) xy(:,2) xy(:,1).^0];
    b = [uv(:,1) uv(:,1) uv(:,1)];
    B = -A.*b;
    c = [uv(:,2) uv(:,2) uv(:,2)];
    C = -A.*c;
    Z = b.*0;
    
    M = [ A Z B ; Z A C];
    
    Q = (M'*M);
    [V D] = eig(Q); % V = autovectores de Q (columnas)
    d = diag(D) ; % d = diagonal de D = autovalores.
    [m, idx]=min(d); % Busca autovalor mínimo.
    h = V(:,idx); % Autovector correspondiente
    P = reshape(h,3,3)'; % Reorganiza h como matriz P 3x3
    P = P/P(3,3); % Normaliza para que P(3,3)=1.
    
return