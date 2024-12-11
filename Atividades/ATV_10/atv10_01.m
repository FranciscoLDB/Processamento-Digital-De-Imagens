% 10) Torre de hanoi

function [pino1, pino2, pino3] = processImage(img)
    % Rotacionar a imagem em -32 graus
    rotatedImg = imrotate(img, -32);

    % Definir a região de corte [x, y, largura, altura]
    rect = [270, 325, 430, 240];
    % Cortar a imagem
    croppedImg = imcrop(rotatedImg, rect);

    % Definir regiões de corte para os pinos
    rect1 = [40, 35, 100, 100];
    rect2 = [170, 107, 100, 100];
    rect3 = [310, 35, 100, 100];

    % Cortar as regiões dos pinos
    pino1 = imcrop(croppedImg, rect1);
    pino2 = imcrop(croppedImg, rect2);
    pino3 = imcrop(croppedImg, rect3);
end

% Função para segmentar uma cor específica
function colorMask = segmentColor(img, color)
    hsvImg = rgb2hsv(img);
    switch color
        case 'red'
            colorMask = (hsvImg(:,:,1) < 0.05 | hsvImg(:,:,1) > 0.95) & hsvImg(:,:,2) > 0.5 & hsvImg(:,:,3) > 0.5;
        case 'yellow'
            colorMask = (hsvImg(:,:,1) > 0.1 & hsvImg(:,:,1) < 0.2) & hsvImg(:,:,2) > 0.5 & hsvImg(:,:,3) > 0.5;
        case 'blue'
            colorMask = (hsvImg(:,:,1) > 0.55 & hsvImg(:,:,1) < 0.65) & hsvImg(:,:,2) > 0.5 & hsvImg(:,:,3) > 0.5;
        case 'green'
            colorMask = (hsvImg(:,:,1) > 0.25 & hsvImg(:,:,1) < 0.4) & hsvImg(:,:,2) > 0.5 & hsvImg(:,:,3) > 0.5;
        case 'orange'
            colorMask = (hsvImg(:,:,1) > 0.05 & hsvImg(:,:,1) < 0.1) & hsvImg(:,:,2) > 0.6 & hsvImg(:,:,3) > 0.5;
        otherwise
            colorMask = false(size(img, 1), size(img, 2));
    end
end

clear; clc; close all;

subdir = 'hanoi_01/';
imageFiles = dir(fullfile(subdir, '*.png'));
colors = {'yellow', 'red', 'blue', 'green', 'orange'};
resultado = zeros(length(imageFiles), length(colors));

for k = 1:length(imageFiles)
    filename = fullfile(subdir, imageFiles(k).name);
    img = imread(filename);
    [pino1, pino2, pino3] = processImage(img);

    % Inicializar matriz para armazenar somas
    sumColors = zeros(3, length(colors));

    % Calcular a soma dos valores segmentados para cada cor e cada imagem
    for i = 1:length(colors)
        color = colors{i};
        sumColors(1, i) = sum(segmentColor(pino1, color), 'all');
        sumColors(2, i) = sum(segmentColor(pino2, color), 'all');
        sumColors(3, i) = sum(segmentColor(pino3, color), 'all');
        [~, idx] = max(sumColors(:, i));
        resultado(k, i) = idx;
    end

    % Salvar a matriz resultado em um arquivo .mat
    save('resultado.mat', 'resultado')
end

fprintf('Acabou :)\n');