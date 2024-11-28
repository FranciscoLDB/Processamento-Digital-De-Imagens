% 9.2) Pseudocolorização

clear; clc; close all;

img = imread('AD21-0016-001_F3_P3_knife_plane_drop_v~small.jpg');

% Converte a imagem para escala de cinza (se não for já)
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Aplica uma pseudocolorização usando a função 'ind2rgb' e um mapa de cores
map = hot();
img_pseudocolor = ind2rgb(uint8(img), map);
map2 = parula();
img_pseudocolor2 = ind2rgb(uint8(img), map2);

% Exibe a imagem original e a imagem pseudocolorizada
figure;
subplot(2, 3, 2);
imshow(img);
title('Imagem Original');

subplot(2, 2, 3);
imshow(img_pseudocolor);
title('Pseudocolorizada 1');

subplot(2, 2, 4);
imshow(img_pseudocolor2);
title('Pseudocolorizada 2');