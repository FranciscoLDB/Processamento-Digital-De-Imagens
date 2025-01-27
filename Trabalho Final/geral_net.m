clear; clc; close all;

function net = trainForColor(color, split, InitialLearnRate, MiniBatchSize)
    disp(['Training started for color: ', color]);
    imageDir = 'dataset/' + color + 'Transformed';
    colorDS = imageDatastore(imageDir, IncludeSubfolders=true, LabelSource="foldernames");
    [trainImgs, testImgs] = splitEachLabel(colorDS, split, 'randomized');
    
    % Aumenta os dados de treinamento e validação
    trainImgs = augmentData(trainImgs, 3);
    testImgs = augmentData(testImgs, 3);
    
    % Certifique-se de que os dados estão no formato correto
    trainImgs = transform(trainImgs, @(x) im2double(x));
    testImgs = transform(testImgs, @(x) im2double(x));

    % Verifique o tipo de dados das imagens
    disp(['Tipo de dados das imagens de treinamento: ', class(readimage(trainImgs, 1))]);
    disp(['Tipo de dados das imagens de teste: ', class(readimage(testImgs, 1))]);
    
    categories(colorDS.Labels);
    net = imagePretrainedNetwork("googlenet", NumClasses=3);
    
    % Ajustar hiperparâmetros
    opts = trainingOptions("sgdm", ...
        'Metrics', 'accuracy', ...
        'InitialLearnRate', InitialLearnRate, ...
        'MaxEpochs', 10, ...
        'MiniBatchSize', MiniBatchSize, ...
        'Shuffle', 'every-epoch', ...
        'ValidationData', resizeTestImgs, ...
        'ValidationFrequency', 10, ...
        'Verbose', true); ...
        %'Plots', 'training-progress');
    
    [net, info] = trainnet(resizeTrainImgs, net, "crossentropy", opts);

    disp(['Training completed for color: ', color]);
end

% Função para aumentar os dados de treinamento e validação
function augmentedDS = augmentData(imageDS, factor)
    % Cria um array de datastores aumentados
    augmentedDS = cell(1, factor);
    
    for i = 1:factor
        % Define as operações de aumento de dados
        augmenter = imageDataAugmenter( ...
            'RandRotation', [-10, 10], ... % Rotação aleatória entre -10 e 10 graus
            'RandXTranslation', [-5, 5], ... % Translação horizontal aleatória entre -5 e 5 pixels
            'RandYTranslation', [-5, 5], ... % Translação vertical aleatória entre -5 e 5 pixels
            'RandXReflection', true, ... % Espelhamento horizontal aleatório
            'RandYReflection', true, ... % Espelhamento vertical aleatório
            'RandXScale', [0.9, 1.1], ... % Escala horizontal aleatória entre 0.9 e 1.1
            'RandYScale', [0.9, 1.1]); % Escala vertical aleatória entre 0.9 e 1.1
        
        % Aplica o aumento de dados ao datastore
        augmentedDS{i} = augmentedImageDatastore([224 224], imageDS, 'DataAugmentation', augmenter);
    end
    
    % Combina todos os datastores aumentados em um único datastore
    augmentedDS = combine(augmentedDS{:});
end

% Parâmetros para avaliação
split = 0.8;
learnRate = 0.003;
batchSize = 32;
colors = ["yellow", "red", "blue", "green", "orange"];
nets = cell(1, length(colors));

% Loop para treinar a rede para cada cor
for i = 1:length(colors)
    nets{i} = trainForColor(colors(i), split, learnRate, batchSize);
end
% Salvar as nets
save('nets.mat', 'nets')