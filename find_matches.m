function [xy1, xy2] = find_matches(s1, s2)
    N1 = size(s1.xy,1);
    N2 = size(s2.xy,1);
    parejas = zeros(N2,1);
    
    for k = 1:N1
        M = 0;
        d1 = s1.id(k,:);
        for j= 1:N2
            if(parejas(j)>0)
            else
               d2=s2.id(j,:);
               m = 1./norm(d1-d2);
               if(m > M)
                   J = j;
                   M = m;
               end
            end
        end
        if(M > 4)
            parejas(J) = k;
        end
    end
    index2 = find(parejas > 0);
    index1 = parejas(index2);
    xy1 = s1.xy(index1,:);
    xy2 = s2.xy(index2,:);
end