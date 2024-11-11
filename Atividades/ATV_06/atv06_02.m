% 6.2) Detecção de bordas usando o método Canny (função edge)

close all; clear; clc;

img = imread('sticknote_gray_01.png');
img_2 = imread('cameraman.tif');

% Definição dos limiares para o método Canny
Tlow1 = 0.05;
Thigh1 = 0.2;
Tlow2 = 0.15;
Thigh2 = 0.35;

% Detecção de bordas usando o método Canny
edges1 = edge(img, 'Canny', [Tlow1 Thigh1]);
edges2 = edge(img, 'Canny', [Tlow2 Thigh2]);
edges1_2 = edge(img_2, 'Canny', [Tlow1 Thigh1]);
edges2_2 = edge(img_2, 'Canny', [Tlow2 Thigh2]);

% Exibição das imagens
figure;
subplot(1,2,1), imshow(img), title('Original');
subplot(1,2,2), imshow(img_2), title('Original');

figure;
subplot(1,2,1), imshow(edges1), title(['Tlow = ' num2str(Tlow1) ' e Thigh = ' num2str(Thigh1)]);
subplot(1,2,2), imshow(edges2), title(['Tlow = ' num2str(Tlow2) ' e Thigh = ' num2str(Thigh2)]);

figure;
subplot(1,2,1), imshow(edges1_2), title(['Tlow = ' num2str(Tlow1) ' e Thigh = ' num2str(Thigh1)]);
subplot(1,2,2), imshow(edges2_2), title(['Tlow = ' num2str(Tlow2) ' e Thigh = ' num2str(Thigh2)]);