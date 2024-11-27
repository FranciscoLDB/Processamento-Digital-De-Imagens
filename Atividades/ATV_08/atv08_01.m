% atv08_01.m
clear; clc; close all;

% Leitura da imagem (substitua pelo caminho do arquivo se necessário)
img = imread('carro1mm_nperiodic.png'); 

% Verifica se a imagem é colorida e converte para escala de cinza se necessário
if size(img, 3) == 3
    img = rgb2gray(img); % Converte imagens RGB para escala de cinza
end
img = double(img); % Converte para double para cálculos

% Cálculo da DFT 2D pela separabilidade (usando DFTs 1D)
dftr = fft(img, [], 1); % DFT das linhas
dft_sep = fft(dftr, [], 2); % DFT das colunas

% Cálculo da DFT 2D diretamente
dft_fft2 = fft2(img);

% Magnitude para visualização (escala logarítmica)
mag_sep = log(1 + abs(dft_sep));
mag_fft2 = log(1 + abs(dft_fft2));

% Exibição dos resultados
figure;
subplot(1, 3, 1);
imshow(img, []);
title('Imagem Original');

subplot(1, 3, 2);
imshow(mag_sep, []);
title('DFT 2D (Separabilidade)');

subplot(1, 3, 3);
imshow(mag_fft2, []);
title('DFT 2D (fft2)');
