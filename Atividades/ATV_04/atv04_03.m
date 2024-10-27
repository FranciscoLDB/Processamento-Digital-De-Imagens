% 4.3) Filtro da Mediana

close all; clear; clc;

% Carregar a imagem com ruído salt-and-pepper
img = imread('salt-and-pepper1.tif');

% Dimensões da imagem
[rows, cols] = size(img);

% Inicializar a imagem de saída
filtered_img = img;

% Aplicar o filtro da mediana com uma janela 3x3
for i = 2:rows-1
    for j = 2:cols-1
        % Extrair a vizinhança 3x3
        window = img(i-1:i+1, j-1:j+1);
        
        % Calcular a mediana dos valores da janela
        median_value = median(window(:));
        
        % Atribuir o valor mediano ao pixel central
        filtered_img(i, j) = median_value;
    end
end

% Exibir a imagem original e a filtrada
figure;
subplot(1, 2, 1);
imshow(img);
title('Imagem Original com Ruído');

subplot(1, 2, 2);
imshow(filtered_img);
title('Imagem Filtrada com Filtro da Mediana');
