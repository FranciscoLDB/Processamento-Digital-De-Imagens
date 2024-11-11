% 6.1) Detecção de bordas usando filtros de gradiente (Sobel na unha)

close all; clear; clc;

img = imread('sticknote_gray_01.png');
img_2 = imread('cameraman.tif');

% Aplicação do filtro de Sobel
sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];

Gx = conv2(double(img), sobel_x, 'same');
Gy = conv2(double(img), sobel_y, 'same');
Gx_2 = conv2(double(img_2), sobel_x, 'same');
Gy_2 = conv2(double(img_2), sobel_y, 'same');

% Cálculo da magnitude
% Usando a norma
M_norm = sqrt(Gx.^2 + Gy.^2);
M_norm_2 = sqrt(Gx_2.^2 + Gy_2.^2);

% Usando a soma dos valores absolutos
M_abs = abs(Gx) + abs(Gy);
M_abs_2 = abs(Gx_2) + abs(Gy_2);

% Exibição das imagens
figure;
subplot(1,2,1), imshow(img), title('Original');
subplot(1,2,2), imshow(img_2), title('Original');

figure;
subplot(1,2,1), imshow(uint8(M_norm)), title('(Norma)');
subplot(1,2,2), imshow(uint8(M_abs)), title('(Soma dos Absolutos)');

figure;
subplot(1,2,1), imshow(uint8(M_norm_2)), title('(Norma)');
subplot(1,2,2), imshow(uint8(M_abs_2)), title('(Soma dos Absolutos)');
