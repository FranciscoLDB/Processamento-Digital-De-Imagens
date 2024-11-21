% 7.2) Rotulação e propriedades de componentes conexos em imagens binárias

close all; clear; clc;

files = dir(fullfile('Atividades/ATV_07/L/', '*.png'));  % Ajuste o caminho conforme necessário

% Inicializar uma célula para armazenar as imagens
images = cell(1, length(files));

% Gabarito para verificação
gabarito = {'Estrela', 'Bispo', 'Retangulo', 'Quadrado', 'Estrela', 'Retangulo', 'Bispo', 'Quadrado'};

% Criar arrays para armazenar os dados das propriedades
areas = zeros(1, length(files));
eccentricities = zeros(1, length(files));
aspectRatios = zeros(1, length(files));
extents = zeros(1, length(files));
solidities = zeros(1, length(files));
perimeters = zeros(1, length(files));
eulerNumbers = zeros(1, length(files));
labels = cell(1, length(files));

for i = 1:length(files)
    % Ler a imagem
    images{i} = imread(fullfile(files(i).folder, files(i).name));
    
    % Converter para binária (ajuste de limiar pode ser necessário)
    images{i} = imbinarize(im2gray(images{i}));
    
    % Obter propriedades dos componentes conexos
    stats = regionprops(images{i}, 'Area', 'Eccentricity', 'BoundingBox', 'Extent', 'Solidity', 'Perimeter', 'EulerNumber');
    
    % Verificar se há componentes
    if ~isempty(stats)
        % Encontrar o componente com maior área
        [~, idx] = max([stats.Area]);
        largestComponent = stats(idx);
        
        % Calcular a orientação da BoundingBox
        angle = -atan2d(largestComponent.BoundingBox(4), largestComponent.BoundingBox(3));
        
        % Rotacionar a imagem para alinhar a orientação
        rotatedImage = imrotate(images{i}, angle);
        
        % Atualizar propriedades após a rotação
        rotatedStats = regionprops(rotatedImage, 'Area', 'Eccentricity', 'BoundingBox', 'Extent', 'Solidity', 'Perimeter', 'EulerNumber');
        largestComponent = rotatedStats(idx);
        
        % Armazenar os dados das propriedades
        areas(i) = largestComponent.Area;
        eccentricities(i) = largestComponent.Eccentricity;
        aspectRatios(i) = largestComponent.BoundingBox(3) / largestComponent.BoundingBox(4);
        extents(i) = largestComponent.Extent;
        solidities(i) = largestComponent.Solidity;
        perimeters(i) = largestComponent.Perimeter;
        eulerNumbers(i) = largestComponent.EulerNumber;
        
        % Ajustando critérios de classificação
        if areas(i) > 5000 && extents(i) > 0.8 && aspectRatios(i) >= 0.9 && aspectRatios(i) <= 1.1 && solidities(i) > 0.95
            labels{i} = 'Quadrado';
        elseif areas(i) > 5000 && extents(i) > 0.8 && aspectRatios(i) > 1.2 && solidities(i) > 0.95
            labels{i} = 'Retangulo';
        elseif eccentricities(i) < 0.5 && solidities(i) > 0.8 && (perimeters(i)/areas(i)) > 0.05 && eulerNumbers(i) >= 0
            labels{i} = 'Estrela';
        else
            labels{i} = 'Bispo';
        end
        
        % Verificar se a classificação está correta
        if strcmp(labels{i}, gabarito{i})
            resultado = 'Correto';
        else
            resultado = 'Incorreto';
        end
        
        % Imprimir resultado
        fprintf('Imagem %d: Classificação %s - %s\n', i, labels{i}, resultado);
    else
        fprintf('Imagem %d: Nenhum componente encontrado\n', i);
    end
end

% Mostrar as imagens em uma mesma figura com seus títulos
figure;
for i = 1:length(images)
    subplot(2, 4, i);  % Ajuste 2x4 conforme necessário para exibir as imagens
    imshow(images{i});
    title(labels{i});
end
