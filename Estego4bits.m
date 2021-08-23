%Fecha: 20/08/2021
%Realiza estegonagráfia de imagen sobre imagen
%LSB em 4 bits
%Imagenes de mismo tamaño
%MATLAB

%limpia pantalla;
%Borra variables;
clc 
clear all 

mesaje01='---> Esteganografía de imagen sobre imagen';
disp(mesaje01);

ImgCover=imread('5.1.09.tiff');
ImgSecrete=imread('5.1.12.tiff');


VectCover=[];
for i=1:256
    for j=1:256
        VectCover=[VectCover; ImgCover(i,j)];
    end
end

VectSecrete=[];
for i=1:256
    for j=1:256
        VectSecrete=[VectSecrete; ImgSecrete(i,j)];
    end
end

%Enmascaramiento de los 4 bits má significativos de imagen cubierta
VectCover2=[];
for i=1:65536
    VectCover2=[VectCover2; bitand(VectCover(i),240)];
end

%VectBinCover=dec2bin(VectCover);
%VectBinSecrete=dec2bin(VectSecrete);
%VectBinCover2=dec2bin(VectCover2);

%Enmascaramiento de los 4 bits má significativos de imagen secreta
VectSecrete2=[];
for i=1:65536
    VectSecrete2=[VectSecrete2; bitand(VectSecrete(i),240)];
end


%VectBinSecrete2=dec2bin(VectSecrete2);

%Corrimiento de los bits más significativos de la imagen secreta
for i=1:65536
  VectSecrete3(i)=bitshift(VectSecrete2(i),-4);
end

%VectBinSecrete3=dec2bin(VectSecrete3);

%Generación de la Estegoimagen
for i=1:65536
    VectEstego(i)=bitor(VectCover2(i),VectSecrete3(i));
end

VectEstego=VectEstego';
%VectBinEstego=dec2bin(VectEstego);

%Formación de la matriz de imagen
ImgEstego=[];
for i=1:256
    for j=1:256
        ImgEstego(i,j)=VectEstego((i-1)*256+j);
    end
end

ImgEstego=uint8(ImgEstego);

figure(1)
title('Imagen cubierta')
imshow(ImgCover);

figure(2)
title('Imagen secreta')
imshow(ImgSecrete);

title('Imagen secreta')
figure(3)
imshow(ImgEstego);











