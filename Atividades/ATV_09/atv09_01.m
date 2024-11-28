% 9.1) Visualização e operação entre os canais R, G, B

clear; clc; close all;

img = imread('greens.jpg');

% Separa os canais de cor
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);

% Operação aritmética simples entre os canais para segmentar as cerejas
% As cerejas são vermelhas, então a diferença entre o canal R e os outros
% dois canais deve ser significativa.
cerejas = (R > G) & (R > B) & (R - G > 50) & (R - B > 50);

% Converte o resultado para um tipo suportado por imbinarize
cerejas = uint8(cerejas);

% Converte para imagem binária
cerejas_bin = imbinarize(cerejas);

% Mostra a imagem original e a imagem binária das cerejas
figure;
subplot(1, 2, 1);
imshow(img);
title('Imagem Original');

subplot(1, 2, 2);
imshow(cerejas_bin);
title('Imagem Binária das Cerejas');
