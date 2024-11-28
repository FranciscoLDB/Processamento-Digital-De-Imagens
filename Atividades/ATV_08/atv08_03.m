% 8.3) Passa-altas e passa-baixas Gaussiano no domínio da frequência
clear; clc; close all;

img = imread('chicomm_nperiodic.png'); 
if size(img, 3) == 3
    img = rgb2gray(img);
end
img = double(img);

% Parâmetros do filtro
sigma = 10; % Defina o valor de sigma (ajustável)
sigma2 = 20; % Defina o valor de sigma (ajustável)
sigma3 = 30; % Defina o valor de sigma (ajustável)

% Dimensões da imagem
[M, N] = size(img);
[X, Y] = meshgrid(-floor(N/2):floor((N-1)/2), -floor(M/2):floor((M-1)/2));

% Filtro passa-baixas Gaussiano
gauss_lp = exp(-(X.^2 + Y.^2) / (2 * sigma^2));
gauss_lp = mat2gray(gauss_lp); % Escala para [0, 1]
gauss_lp2 = exp(-(X.^2 + Y.^2) / (2 * sigma2^2));
gauss_lp2 = mat2gray(gauss_lp2); % Escala para [0, 1]
gauss_lp3 = exp(-(X.^2 + Y.^2) / (2 * sigma3^2));
gauss_lp3 = mat2gray(gauss_lp3); % Escala para [0, 1]

% Filtro passa-altas Gaussiano
gauss_hp = 1 - gauss_lp;
gauss_hp2 = 1 - gauss_lp2;
gauss_hp3 = 1 - gauss_lp3;

% Transformada de Fourier da imagem
dft_img = fftshift(fft2(img));

% Aplicação dos filtros no domínio da frequência
img_lp = real(ifft2(ifftshift(dft_img .* gauss_lp))); % Passa-baixas
img_hp = real(ifft2(ifftshift(dft_img .* gauss_hp))); % Passa-altas
img_lp2 = real(ifft2(ifftshift(dft_img .* gauss_lp2))); % Passa-baixas
img_hp2 = real(ifft2(ifftshift(dft_img .* gauss_hp2))); % Passa-altas
img_lp3 = real(ifft2(ifftshift(dft_img .* gauss_lp3))); % Passa-baixas
img_hp3 = real(ifft2(ifftshift(dft_img .* gauss_hp3))); % Passa-altas

% Exibição dos resultados para diferentes filtros
% Definição dos conjuntos de filtros e imagens processadas
filtros_lp = {gauss_lp, gauss_lp2, gauss_lp3};
filtros_hp = {gauss_hp, gauss_hp2, gauss_hp3};
imagens_lp = {img_lp, img_lp2, img_lp3};
imagens_hp = {img_hp, img_hp2, img_hp3};
titulos = {'Filtro Passa-Baixas', 'Filtro Passa-Altas', ...
           'Passa-Baixas', 'Passa-Altas'};

for i = 1:3
    figure;
    % Imagem Original
    subplot(2, 3, 1);
    imshow(img, []);
    title('Imagem Original');

    % Filtros Passa-Baixas
    subplot(2, 3, 2);
    imshow(filtros_lp{i}, []);
    title(titulos{1});

    % Filtros Passa-Altas
    subplot(2, 3, 3);
    imshow(filtros_hp{i}, []);
    title(titulos{2});

    % Espectro da Imagem Original
    subplot(2, 3, 4);
    imshow(log(1 + abs(dft_img)), []);
    title('Espectro da Imagem Original');

    % Imagem Passa-Baixas
    subplot(2, 3, 5);
    imshow(imagens_lp{i}, []);
    title(titulos{3});

    % Imagem Passa-Altas
    subplot(2, 3, 6);
    imshow(imagens_hp{i}, []);
    title(titulos{4});
end
