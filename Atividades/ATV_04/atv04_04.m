% 4.4) Realce

close all; clear; clc;

% Carregar a imagem
img = imread('flowervaseg.png');

% Definir as máscaras
mask_OM = [0 -1 0; -1 5 -1; 0 -1 0];  % Composite Laplacian [OM]
mask_LG = [-1 -1 -1; -1 9 -1; -1 -1 -1];  % Variação do Composite Laplacian [LG]

% Aplicar as máscaras à imagem usando convolução
sharpened_OM = imfilter(img, mask_OM, 'conv');
sharpened_LG = imfilter(img, mask_LG, 'conv');

% Exibir a imagem original e as imagens realçadas
figure;
subplot(1, 3, 1);
imshow(img);
title('Imagem Original');

subplot(1, 3, 2);
imshow(sharpened_OM);
title('Composite Laplacian [OM]');

subplot(1, 3, 3);
imshow(sharpened_LG);
title('Composite Laplacian [LG]');
