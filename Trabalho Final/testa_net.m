clear; clc; close all;

% Script para testar a rede com as imagens
% Esta retornando tudo com msm resultado por algum motivo

% Função para processar as imagens
function processedImg = processImage(img)
    % Rotacionar a imagem em -32 graus
    rotatedImg = imrotate(img, -32);

    % Definir a região de corte [x, y, largura, altura]
    rect = [270, 325, 430, 240];
    % Cortar a imagem
    processedImg = imcrop(rotatedImg, rect);
end

% Função para classificar a posição dos discos em uma nova imagem
function positions = classifyDisks(img, nets, colors)
    processedImg = processImage(img);
    resizedImg = imresize(processedImg, [224 224]);
    resizedImg = im2double(resizedImg); % Converter para double
    positions = zeros(1, length(colors));
    for i = 1:length(colors)
        net = nets{i};
        dlImg = dlarray(resizedImg, 'SSC');
        scores = predict(net, dlImg);
        [~, label] = max(scores);
        positions(i) = label;
    end
end

% Exemplo de uso
load nets.mat;
colors = ["yellow", "red", "blue", "green", "orange"];

subdir = 'hanoi_01/';
imageFiles = dir(fullfile(subdir, '*.png'));
for k = 1:length(imageFiles)
    filename = fullfile(subdir, imageFiles(k).name);
    img = imread(filename);
    positions = classifyDisks(img, nets, colors);
    disp(['File: ', filename]);
    disp(['Positions: ', mat2str(positions)]);
end