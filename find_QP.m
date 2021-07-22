function[Q, P]=find_QP(s)
    NF = size(s,2);
    Q=zeros(NF);
    P=cell(NF);
    M = 0;
    R = 0;
    for i=1:NF
        for j=i+1:NF
            [xy1, xy2] = find_matches(s{i},s{j});
            if(size(xy1,1)>10)
                M = M + size(xy1,1);
                [T, Nok]=ransac(xy1,xy2);
                R = R + Nok;
                if(Nok>=8)
                   Q(i,j) = Nok;
                   Q(j,i) = Nok;
                   P{i,j}=T;
                   P{j,i}=inv(T);
                end
            end
            
        end
    end
    R
    M
    porc = (R/M)*100
end