clear; clc; close all;

% Script para treinar as redes

function net = trainForColor(color, split, InitialLearnRate, MiniBatchSize)
    disp(['Training started for color: ', color]);
    imageDir = 'dataset/' + color + 'Transformed';
    colorDS = imageDatastore(imageDir, IncludeSubfolders=true, LabelSource="foldernames");
    [trainImgs, testImgs] = splitEachLabel(colorDS, split, 'randomized');
    resizeTrainImgs = augmentedImageDatastore([224 224], trainImgs);
    resizeTestImgs = augmentedImageDatastore([224 224], testImgs);
    
    categories(colorDS.Labels);
    net = imagePretrainedNetwork("resnet50", NumClasses=3);
    
    % Ajustar hiperparâmetros
    opts = trainingOptions("sgdm", ...
        'Metrics', 'accuracy', ...
        'InitialLearnRate', InitialLearnRate, ...
        'MaxEpochs', 30, ...
        'MiniBatchSize', MiniBatchSize, ...
        'Shuffle', 'every-epoch', ...
        'ValidationData', resizeTestImgs, ...
        'ValidationFrequency', 10, ...
        'Verbose', true); ...
        %'Plots', 'training-progress');
    
    [net, info] = trainnet(resizeTrainImgs, net, "crossentropy", opts);

    disp(['Training completed for color: ', color]);
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