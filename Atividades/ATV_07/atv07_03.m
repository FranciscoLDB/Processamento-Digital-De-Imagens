% 7.3) Limiarização local (também chamada de limiarização adaptativa)
% baseada na média

close all; clear; clc;

img = imread('rice.png');

% Verificar se a imagem está em escala de cinza
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Parâmetros para adaptthresh
neighborhoodSize = [101, 101]; % Tamanho da vizinhança (sxs)
sensitivity = 0.47;           % Sensibilidade (t)

% Aplicar a limiarização adaptativa
T = adaptthresh(img, sensitivity, 'NeighborhoodSize', neighborhoodSize);
binaryImg = imbinarize(img, T);

% Mostrar os resultados
figure;
subplot(1, 2, 1);
imshow(img);
title('Original');

subplot(1, 2, 2);
imshow(binaryImg);
title('Binarizada (adaptthresh)');