%
%
% Aleix Martínez Vinent
% 12-11-2019
% 
%
% 1. Llegir imatge
% 2. Dos arrays randoms uniformes entre 0 i 1 (de tants valors com files tengui
% imatge). Un serveix per detectar llindar i un altre per desplaçament
% 3. Elecció de percentatge de error. Aquell percentatge serà llindar de
% l'array.
% 4. Bucle que desplaça (valor de l'array * 100 píxels) cap a l'esquerra a aquelles files que es superi el llindar 
%
%

LL = 0.5;     % Llindar de rand1 per desplaçar aquella fila rand1(x). Es modifica si és major
Q = 500;      % Grau de desplaçament (>100)
A = 0;        % Activador de desplaçament bidireccional
D = 1;        % D=1 significa desplaçament cap a la dreta en cas de A=1. D=0, esquerra.

% 1
[file,path] = uigetfile('*.jpg');
dir = strcat(path, file);
img = imread(dir);

% 2
NH = length(img(:,1,1));
NV = length(img(1,:,:));
rand1 = rand(1,NH);
rand2 = rand(1,NH);

if A==1
    rand3 = rand(1,NH);
else
    rand3=ones(1,NH);
end

for k = 1:length(rand3)
    if rand3(k) >= 0.5
        rand3(k) = 1;
    else
        rand3(k) = 0;
    end 
end

for i=1:NH
    if(rand1(i))>LL
        temp = img(i,:,:);
        D = fix(rand2(1,i,1)*Q);
        if(rand3(i) == 1)
            for j=1:NV
              if D==1 && A==0
                if (j+D) > length(temp)
                   img(i,j,:) = temp(1,j+D-length(temp),:);
                else
                   img(i,j,:) = temp(1,j+D,:); 
                end
                  
              else
                  if (j-D) < 1
                    img(i,j,:) = temp(1,j-D+length(temp),:);
                  else
                   img(i,j,:) = temp(1,j-D,:); 
                  end
              end            
            end 
        else
            for j=1:NV
                if (j+D) > length(temp)
                   img(i,j,:) = temp(1,j+D-length(temp),1);
                else
                   img(i,j,:) = temp(1,j+D,:); 
                end
            end 
        end

    end
end 

imshow(img);
imwrite(img, strcat("modificat_",file));
