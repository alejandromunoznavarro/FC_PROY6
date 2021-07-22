function key=fc_parse_keyfile(fich,rg)

if nargin==1, rg=[2.5 3.5]; end

fid = fopen(fich,'r');
if fid == -1, error('Fichero %s no existe/no pudo ser abierto',fich); end

data = fscanf(fid,'%d %d', [1 2]);
N = data(1); L = data(2);
data = fscanf(fid,'%f', [4+L N])';  
fclose(fid);

%fprintf('%s: N puntos org %d ',fich,size(data,1));
data = elimina_repes(data); N = size(data,1);
%fprintf('Eliminando repetidos: %d ',N);

% Normaliza descriptores
for k=1:N
  dd = data(k,5:end); % descriptores;
  data(k,5:end)=dd/norm(dd);   
end    

% Organiza datos en estructura.
key = struct('xy',data(:,[2 1]),'id',data(:,5:end)); 

Nfin=N;

% Filtro por escala  
smin=rg(1); smax=rg(2);esc=data(:,3); 
keep = (esc>=smin) & (esc<=smax);   Nfin=sum(keep);   
key.id=key.id(keep,:);
key.xy=key.xy(keep,:);  


% if filtra,    
%   % Filtra por varianza de descriptores ??
%   v=var(data(:,5:end)');
%   V=max(v); keep=(v>0.8*V);         
% end  

 fprintf('Tras eliminar repetidos y reducir nº de puntos: %d\n',Nfin);      

return


function data = elimina_repes(data)

X=data(:,2);
Y=data(:,3);
L = length(X);

repes=zeros(L,1); elim=0;
for k=1:L-1 
 if (repes(k)==1), continue;  end       
 bad = (abs(X(k+1:end)-X(k))<=0.1) & (abs(Y(k+1:end)-Y(k))<=0.1); 
 if (sum(bad)>0)
   q=find(bad);
   repes(k+q)=1;
   elim=elim+sum(bad);
%     fprintf('k %d  %.4f %.4f\n',k,X(k),Y(k)); 
%     fprintf('  %d  %.4f %.4f\n',[k+q X(k+q) Y(k+q)]'); 
%     fprintf('-----------\n');
%     if sum(bad)>1, pause; end  
 end    
    
end    

 data=data(~repes,:);
 return
