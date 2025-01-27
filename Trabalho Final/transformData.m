clear; clc; close all;

% Script para transformar as imagems, "para facilitar a rede?"

% Função para processar as imagens
function processedImg = processImage(img)
    % Rotacionar a imagem em -32 graus
    rotatedImg = imrotate(img, -32);

    % Definir a região de corte [x, y, largura, altura]
    rect = [270, 325, 430, 240];
    % Cortar a imagem
    processedImg = imcrop(rotatedImg, rect);
end

% Diretórios de entrada e saída
inputDirs = {'dataset/yellow/1', 'dataset/yellow/2', 'dataset/yellow/3'};
outputDirs = {'dataset/yellowTransformed/1', 'dataset/yellowTransformed/2', 'dataset/yellowTransformed/3'};

% Criar diretórios de saída se não existirem
for i = 1:length(outputDirs)
    if ~exist(outputDirs{i}, 'dir')
        mkdir(outputDirs{i});
    end
end

% Processar e salvar as imagens
for i = 1:length(inputDirs)
    inputDir = inputDirs{i};
    outputDir = outputDirs{i};
    imageFiles = dir(fullfile(inputDir, '*.*'));
    for j = 1:length(imageFiles)
        [~, ~, ext] = fileparts(imageFiles(j).name);
        if ismember(ext, {'.png', '.jpg', '.jpeg'})
            inputPath = fullfile(inputDir, imageFiles(j).name);
            outputPath = fullfile(outputDir, imageFiles(j).name);
            img = imread(inputPath);
            processedImg = processImage(img);
            imwrite(processedImg, outputPath);
        end
    end
end

disp('Imagens processadas e salvas com sucesso.');