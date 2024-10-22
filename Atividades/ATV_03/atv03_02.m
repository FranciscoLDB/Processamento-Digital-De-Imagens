% 3.2) Equalização do histograma na unha

close all; clear; clc;

% 1.
img = imread('gDSC04422m16.png');
hist = imhist(img);

% 2.
[M, N] = size(img); % Obtém o número de pixels
hist_norm = hist / (M * N); % Normaliza o histograma

% 3.
cdf = cumsum(hist_norm); % Acumula o histograma

% 4.
nivel_cinza = uint8(255 * cdf); % Multiplica por 255 e transforma em uint8

% 5.
img_transformada = intlut(img, nivel_cinza); % Aplica a transformação

%
img_histeq = histeq(img, 256);

figure;
subplot(2,2,1), imshow(img), title('Imagem Original');
subplot(2,2,3), imshow(img_transformada), title('Imagem Equalizada na Unha');
subplot(2,2,4), imshow(img_histeq), title('Imagem Equalizada com histeq');

figure;
subplot(2,2,1), imhist(img), title('Histograma Original');
subplot(2,2,3), imhist(img_transformada), title('Histograma Equalizado na Unha');
subplot(2,2,4), imhist(img_histeq), title('Histograma Equalizado com histeq');

