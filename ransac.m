function [T, Nok]=ransac(xy1,xy2)
    NP = size(xy2,1);
    ok = [];
    for k = 1:1000
        exit=0;
        while(exit==0)
            idx = floor((NP-1).*rand(4,1) + 1);
            idx=unique(idx,'stable');
            if(length(idx)==4)
                exit=1;
            end
        end
        xy3 = xy1(idx,:);
        xy4 = xy2(idx,:);
        P=get_proy(xy3,xy4);
        error=error_ajuste(P,xy1,xy2);
        cerca=find(error<0.5);
        if(length(cerca) > length(ok))
            ok = cerca;
            T = P;
        end
    end
    Nok = length(ok);
end