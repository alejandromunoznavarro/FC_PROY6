function T=enlaza(Q,P)
    NF = size(Q,1);
    % Buscamos la fila que mas se repite sin valores nulos
    [row,col] = find(Q);
    ancla = row(1);
    contador = sum(row == ancla);
    puntos = sum(Q(ancla,:));
    for k = 2:size(row,1)
        if(ancla~=k)
            if(sum(row == k)>contador)
                contador = sum(row == k);
                ancla = k;
                puntos = sum(Q(k,:));
    % Si coincide con otra en repeticiones comparamos el número de puntos
            elseif(sum(row == k)==contador && sum(Q(k,:))>puntos)
                puntos = sum(Q(k,:));
                ancla = k;
            end 
        end
    end
    
    T = cell(1,NF);
    proc = false(1,NF);
    T{ancla}=eye(3);
    proc(ancla)=true;
    
    while (size(find(not(proc))) ~=0)
        usadas = find(proc);
        sin_usar = find(not(proc));
        A = Q(sin_usar,usadas);
        [M, pos]=max(A(:));
        pos=pos(1);
        [i,j]=ind2sub(size(A),pos);
        
        T{sin_usar(i)} = T{usadas(j)} * P{sin_usar(i),usadas(j)};
        proc(sin_usar(i))=true;
    end
end