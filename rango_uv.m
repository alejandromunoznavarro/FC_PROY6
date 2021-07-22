function [RU,RV]=rango_uv(s,P)
    N = s(1);
    M = s(2);
    X = [1 M M 1];
    Y = [1 1 N N];
    H = [X;Y;X.^0];
    uv = P*H;
    u = uv(1,:)./uv(3,:);
    v = uv(2,:)./uv(3,:);
    u_min = ceil(min(u));
    u_max = floor(max(u));
    RU=(u_min:u_max);
    v_min = ceil(min(v));
    v_max = floor(max(v));
    RV=(v_min:v_max);
end