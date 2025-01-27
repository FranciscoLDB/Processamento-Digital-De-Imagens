clear; clc; close all;

% Script para testar as redes com diferentes parametros, e ver os resultados

function results = trainForColor(color, split, InitialLearnRate, MiniBatchSize)
    %disp(['Training started for color: ', color]);
    imageDir = 'dataset/' + color + 'Transformed';
    colorDS = imageDatastore(imageDir,IncludeSubfolders=true,LabelSource="foldernames");
    [trainImgs,testImgs] = splitEachLabel(colorDS,split,'randomized');
    resizeTrainImgs = augmentedImageDatastore([224 224],trainImgs);
    resizeTestImgs = augmentedImageDatastore([224 224],testImgs);
    
    categories(colorDS.Labels);
    net = imagePretrainedNetwork("resnet50",NumClasses=3);
    
    % Ajustar hiperparâmetros
    opts = trainingOptions("sgdm", ...
        'Metrics','accuracy',...
        'InitialLearnRate',InitialLearnRate, ...
        'MaxEpochs',40, ...
        'MiniBatchSize',MiniBatchSize, ...
        'Shuffle','every-epoch', ...
        'ValidationData',resizeTestImgs, ...
        'ValidationFrequency',10, ...
        'Verbose',true); ...
        %'Plots','training-progress');
    
    [colorrnet, info] = trainnet(resizeTrainImgs,net,"crossentropy",opts);

     % Salvar resultados
    results.TrainingLoss = info.TrainingHistory.Loss;
    results.ValidationLoss = info.ValidationHistory.Loss;
    results.TrainingAccuracy = info.TrainingHistory.Accuracy;
    results.ValidationAccuracy = info.ValidationHistory.Accuracy;

    % Adicionar parâmetros de treinamento aos resultados
    results.Split = split;
    results.InitialLearnRate = InitialLearnRate;
    results.MiniBatchSize = MiniBatchSize;
    disp(['Training completed for color: ', color]);
end

colors = ["yellow", "red", "blue", "green", "orange"];

% Parâmetros para avaliação
splits = [0.6, 0.7, 0.8];
learnRates = [0.001, 0.005, 0.0005, 0.008];
batchSizes = [32, 64, 128];

% Inicializar estrutura para salvar os melhores resultados
bestResults = struct( ...
    'TrainingLoss', [], 'ValidationLoss', [], 'TrainingAccuracy', [], 'ValidationAccuracy', [], ...
    'Split', [], 'InitialLearnRate', [], 'MiniBatchSize', []);

% Loop para treinar a rede com diferentes parâmetros
for split = splits
    for learnRate = learnRates
        for batchSize = batchSizes
            for repeat = 1:5 % Repetir 5 vezes para cada conjunto de parâmetros
                results = trainForColor("yellow", split, learnRate, batchSize);
                
                % Atualizar os melhores resultados se necessário
                if isempty(bestResults.TrainingLoss) || results.ValidationAccuracy(end) > bestResults.ValidationAccuracy(end)
                    bestResults = results;
                end
            end
        end
    end
end

% Salvar os melhores resultados em um arquivo MAT
save('bestResults.mat', 'bestResults');