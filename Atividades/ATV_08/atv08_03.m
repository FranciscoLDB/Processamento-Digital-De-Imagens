% atv08_03.m
clear; clc; close all;

% Leitura da imagem (substitua pelo caminho do arquivo se necessário)
img = imread('carro1mm_nperiodic.png'); 
if size(img, 3) == 3
    img = rgb2gray(img); % Converte para escala de cinza
end
img = double(img);

% Parâmetros do filtro
sigma = 20; % Defina o valor de sigma (ajustável)

% Dimensões da imagem
[M, N] = size(img);
[X, Y] = meshgrid(-floor(N/2):floor((N-1)/2), -floor(M/2):floor((M-1)/2));

% Filtro passa-baixas Gaussiano
gauss_lp = exp(-(X.^2 + Y.^2) / (2 * sigma^2));
gauss_lp = mat2gray(gauss_lp); % Escala para [0, 1]

% Filtro passa-altas Gaussiano
gauss_hp = 1 - gauss_lp;

% Transformada de Fourier da imagem
dft_img = fftshift(fft2(img));

% Aplicação dos filtros no domínio da frequência
img_lp = real(ifft2(ifftshift(dft_img .* gauss_lp))); % Passa-baixas
img_hp = real(ifft2(ifftshift(dft_img .* gauss_hp))); % Passa-altas

% Exibição dos resultados
figure;

subplot(2, 3, 1);
imshow(img, []);
title('Imagem Original');

subplot(2, 3, 2);
imshow(gauss_lp, []);
title('Filtro Passa-Baixas');

subplot(2, 3, 3);
imshow(gauss_hp, []);
title('Filtro Passa-Altas');

subplot(2, 3, 4);
imshow(img_lp, []);
title('Imagem Filtrada (Passa-Baixas)');

subplot(2, 3, 5);
imshow(img_hp, []);
title('Imagem Filtrada (Passa-Altas)');

subplot(2, 3, 6);
imshow(log(1 + abs(dft_img)), []);
title('Espectro da Imagem Original');
