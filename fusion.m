clear;
clc;
NF = 3;
name='gala_';
x = input("Escribe una opción:\n(1) Básica.\n(2) Ajuste.\n(3) Normalización por canal y saturación.\n--> ");
switch x
    case 1
        P=cell(1,NF);
        NL = 6;
        for k = 1:NF
            fich  = sprintf('%s%d.jpg',name,k);
            im = imread(fich);
            P{k} = lap(im,NL);
        end
        
        A = P{1};
        B = P{2};
        C = P{3};
        medias=P{1};
        medias{NL} = (A{NL}+B{NL}+C{NL})./3;
        for k=1:NL-1
            im = medias{k};
            
            for i = 1:size(im,1)
                for j = 1:size(im,2)
                    im(i,j) = max([A{k}(i,j) B{k}(i,j) C{k}(i,j)]);
                end
            end
            medias{k}=im;
        end
        
        im = invlap(medias);
        % Primero ajustamos el valor por el mínimo si es necesario
        if(min(im)<0)
            im = im-min(im);
        end
        % Después ajustamos el valor por el máximo si es necesario
        if(max(im)>1)
            im = im./max(im);
        end
        
        % Cambiamos a HSV y aplicamos función
        fprintf('E. Retoques de Brillo/Contraste/Saturacion\n');
        im=rgb2hsv(im);
        clip = 0.01;
        im(:,:,3) = adapthisteq(im(:,:,3),'ClipLimit',clip);
        p=0.7;
        im(:,:,2)=im(:,:,2).^p;
        im=hsv2rgb(im);
        figure(1);
        hold on, title("Caso 1"), imshow(uint8(im*255)), hold off;
    

    case 2
        load keypoints2;
        [Q, P]=find_QP(s);
        ancla = 1;
        T = cell(1,NF);
        T{1}=eye(3);
        T{2}=P{2,1};
        T{3}=P{3,1};

        P=cell(1,NF);
        NL = 6;
        for k = 1:3
            fich  = sprintf('%s%d.jpg',name,k);
            im = im2double(imread(fich));
            im2 = aplica_T(im,T{k});

            A=~isnan(im2(:,:,:));

            %  Reducir para mejorar la velocidad del programa   
            for i=1:size(im2,1)
                for j=1:size(im2,2)
                    if(A(i,j,:))
                        im(i,j,:)=im2(i,j,:);
                    end
                end
            end 
            % Recortamos
            im = im(2:end-1 , 2:end-1 , :);
            mul1 = floor(size(im,1)/32);
            mul2 = floor(size(im,2)/32);
            im = im(1:(mul1*32), 1:(mul2*32), :);
            P{k} = lap(im,NL);
        end


        A = P{1};
        B = P{2};
        C = P{3};
        medias=P{1};
        medias{NL} = (A{NL}+B{NL}+C{NL})./3;
        for k=1:NL-1
            im = medias{k};

            for i = 1:size(im,1)
                for j = 1:size(im,2)
                    im(i,j) = max([A{k}(i,j) B{k}(i,j) C{k}(i,j)]);
                end
            end
            medias{k}=im;
        end

        im = invlap(medias);
        % Primero ajustamos el valor por el mínimo si es necesario
        if(min(im)<0)
            im = im-min(im);
        end
        % Después ajustamos el valor por el máximo si es necesario
        if(max(im)>1)
            im = im./max(im);
        end
        % Cambiamos a HSV y aplicamos función
        fprintf('E. Retoques de Brillo/Contraste/Saturacion\n');
        im=rgb2hsv(im);
        clip = 0.01;
        im(:,:,3) = adapthisteq(im(:,:,3),'ClipLimit',clip);
        p=0.7;
        im(:,:,2)=im(:,:,2).^p;
        im=hsv2rgb(im);
        figure(2);
        hold on, title("Caso 2"), imshow(uint8(im*255)), hold off;
        
    case 3
        load keypoints2;
        [Q, P]=find_QP(s);
        ancla = 1;
        T = cell(1,NF);
        T{1}=eye(3);
        T{2}=P{2,1};
        T{3}=P{3,1};

        P=cell(1,NF);
        NL = 6;
        for k = 1:3
            fich  = sprintf('%s%d.jpg',name,k);
            im = im2double(imread(fich));
            im2 = aplica_T(im,T{k});

            A=~isnan(im2(:,:,:));

            %  Reducir para mejorar la velocidad del programa   
            for i=1:size(im2,1)
                for j=1:size(im2,2)
                    if(A(i,j,:))
                        im(i,j,:)=im2(i,j,:);
                    end
                end
            end 
            % Recortamos
            im = im(2:end-1 , 2:end-1 , :);
            mul1 = floor(size(im,1)/32);
            mul2 = floor(size(im,2)/32);
            im = im(1:(mul1*32), 1:(mul2*32), :);
            P{k} = lap(im,NL);
        end


        A = P{1};
        B = P{2};
        C = P{3};
        medias=P{1};
        medias{NL} = (A{NL}+B{NL}+C{NL})./3;
        for k=1:NL-1
            im = medias{k};

            for i = 1:size(im,1)
                for j = 1:size(im,2)
                    im(i,j) = max([A{k}(i,j) B{k}(i,j) C{k}(i,j)]);
                end
            end
            medias{k}=im;
        end

        im = invlap(medias);
        for k=1:3
            % Primero ajustamos el valor por el mínimo si es necesario
            if(min(im(:,:,k))<0)
                im = im-min(im(:,:,k));
            end
            % Después ajustamos el valor por el máximo si es necesario
            if(max(im(:,:,k))>1)
                im = im./max(im(:,:,k));
            end
        end
        % Cambiamos a HSV y aplicamos función
        fprintf('E. Retoques de Brillo/Contraste/Saturacion\n');
        im=rgb2hsv(im);
        clip = input('Luminancia: ');
        im(:,:,3) = adapthisteq(im(:,:,3),'ClipLimit',clip);
        p = input('Saturación (1): ');
        im(:,:,2)=im(:,:,2).^p;
        im=hsv2rgb(im);
        figure(3);
        hold on, title("Caso 3"), imshow(uint8(im*255)), hold off;
end