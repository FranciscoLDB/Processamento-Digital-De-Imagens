% 4.2) Filtro Gaussiano

close all; clear; clc;

% Carregar a imagem de RM
img = imread('b5s.40.bmp');

% Exibir a imagem original
figure;
subplot(1, 3, 1);
imshow(img);
title('Imagem Original');

% Aplicar o filtro Gaussiano com imgaussfilt, sigma 2
sigma1 = 2;
img_gauss1 = imgaussfilt(img, sigma1);

% Aplicar o filtro Gaussiano com imgaussfilt, sigma 5
sigma2 = 5;
img_gauss2 = imgaussfilt(img, sigma2);

% Exibir a imagem filtrada
subplot(1, 3, 2);
imshow(img_gauss1);
title(['Sigma = ', num2str(sigma1)]);

% Exibir a imagem filtrada
subplot(1, 3, 3);
imshow(img_gauss2);
title(['Sigma = ', num2str(sigma2)]);
