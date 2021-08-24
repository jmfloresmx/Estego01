%Fecha: 20/08/2021
%Fecha Actualización:23/08/2021
%Realiza estegonagráfia de imagen sobre imagen
%LSB de 4 bits
%Imagenes en gris de mismo tamaño
%Código MATLAB

%limpia pantalla;
%Borra variables;
clc 
clear all 

mesaje01='---> Esteganografía de imagen sobre imagen';
disp(mesaje01);

ImgCover=imread('5.1.09.tiff');
ImgSecrete=imread('5.1.12.tiff');

[numf,numc]=size(ImgCover);

VectCover=[];
for i=1:numf
    for j=1:numc
        VectCover=[VectCover; ImgCover(i,j)];
    end
end

VectSecrete=[];
for i=1:size(ImgSecrete,1)
    for j=1:size(ImgSecrete,1)
        VectSecrete=[VectSecrete; ImgSecrete(i,j)];
    end
end

%Enmascaramiento de los 4 bits má significativos de imagen cubierta
VectCover2=[];
%240='1111 0000'
for i=1:numf*numc
    VectCover2=[VectCover2; bitand(VectCover(i),240)];
end


%Enmascaramiento de los 4 bits má significativos de imagen secreta
VectSecrete2=[];
for i=1:numf*numc
    VectSecrete2=[VectSecrete2; bitand(VectSecrete(i),240)];
end


%Corrimiento de los bits más significativos de la imagen secreta
for i=1:numf*numc
  VectSecrete3(i)=bitshift(VectSecrete2(i),-4);
end

%Generación de la Estegoimagen
for i=1:numf*numc
    VectEstego(i)=bitor(VectCover2(i),VectSecrete3(i));
end

VectEstego=VectEstego';
ImgEstego=[];
for i=1:numf
    for j=1:size(ImgCover,2)
        ImgEstego(i,j)=VectEstego((i-1)*numf+j);
    end
end

ImgEstego=uint8(ImgEstego);

figure(1)
imshow(ImgCover);
title('Imagen cubierta')

figure(2)
imshow(ImgSecrete);
title('Imagen secreta')

figure(3)
imshow(ImgEstego);
title('Imagen Estego')







