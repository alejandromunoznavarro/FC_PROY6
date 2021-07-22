function err=error_ajuste(P,xy1,xy2)
    
    H = [xy1';xy1(:,1)'.^0];
    uv = P*H;
    u=uv(1,:)./uv(3,:);
    v=uv(2,:)./uv(3,:);
    du=abs(u-xy2(:,1)');
    dv=abs(v-xy2(:,2)');
    err = sqrt(du.^2+dv.^2)';
end