% 7.1) Morfologia matemática (dilatação, erosão, fechamento, 
% abertura, funções strel, imdilate, imerode, imopen, imclose)

close all; clear; clc;

images = {'psl1_gray.png', 'psl2_gray.png', 'psl3_gray.png'};
original_images = cell(1, length(images));
segmented_images = cell(1, length(images));

for i = 1:length(images)
    % Ler a imagem em escala de cinza
    img = imread(images{i});
    original_images{i} = img; % Salvar imagem original para exibição
    
    % Binarizar a imagem usando o método de Otsu
    level = graythresh(img); % Determinar o limiar de Otsu
    binary_img = imbinarize(img, level); % Binarização
    
    % Complementar para ter objetos como '1' (branco) e fundo como '0' (preto)
    binary_img = imcomplement(binary_img);
    
    % Operação de abertura para remover ruído
    se = strel('disk', 5); % Elemento estruturante circular
    opened_img = imopen(binary_img, se);
    
    % Operação de fechamento para suavizar bordas e preencher buracos
    closed_img = imclose(opened_img, se);
    
    % Remover componentes desconexos que não são a lesão principal
    cleaned_img = bwareafilt(closed_img, 1); % Mantém apenas o maior componente
    
    % Salvar imagem segmentada
    segmented_images{i} = cleaned_img;
end

% Mostrar as imagens originais e segmentadas
figure;
for i = 1:length(images)
    subplot(2, length(images), i);
    imshow(original_images{i});
    title(['Original ', num2str(i)]);
    
    subplot(2, length(images), i + length(images));
    imshow(segmented_images{i});
    title(['Segmentada ', num2str(i)]);
end

