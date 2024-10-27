% 4.1) Funções box e Gaussiana

close all; clear; clc;

% Parte 4.1 a: Filtro Box 3x3
% Criando a máscara do filtro de média 3x3
box_filter = ones(3, 3) / 9;

% Exibindo o filtro Box 3x3 em um gráfico 3D
figure;
subplot(1, 2, 1);
bar3(box_filter);
title('Filtro Box 3x3');
xlabel('X');
ylabel('Y');
zlabel('Peso');

% Parte 4.1 b: Filtro Gaussiano 5x5 com sigma = 1
% Definindo os parâmetros do filtro Gaussiano
sigma = 1;
size = 5;
center = floor(size / 2);

% Criando a máscara do filtro Gaussiano 5x5
gaussian_filter = zeros(size, size);
for i = 1:size
    for j = 1:size
        x = i - (center + 1);
        y = j - (center + 1);
        gaussian_filter(i, j) = (1 / (2 * pi * sigma^2)) * exp(-(x^2 + y^2) / (2 * sigma^2));
    end
end

% Normalizando o filtro Gaussiano para que a soma seja 1
gaussian_filter = gaussian_filter / sum(gaussian_filter(:));

% Exibindo o filtro Gaussiano 5x5 em um gráfico 3D
subplot(1, 2, 2);
bar3(gaussian_filter);
title('Filtro Gaussiano 5x5');
xlabel('X');
ylabel('Y');
zlabel('Peso');
