% 8.2) Invariabilidade do espectro à translação e resposta à rotação
clear; clc; close all;

% Tamanho da imagem
img_size = 256;

% Imagem 1: Quadrado no centro
img1 = zeros(img_size);
img1(96:160, 96:160) = 255;

% Imagem 2: Quadrado deslocado
img2 = circshift(img1, [50, 50]);

% Imagem 3: Quadrado rotacionado
img3 = imrotate(img1, 45, 'crop');

% Cálculo do espectro para cada imagem
dft1 = fftshift(fft2(img1));
dft2 = fftshift(fft2(img2));
dft3 = fftshift(fft2(img3));

% Magnitude para visualização (escala logarítmica)
mag1 = log(1 + abs(dft1));
mag2 = log(1 + abs(dft2));
mag3 = log(1 + abs(dft3));

% Exibição das imagens e espectros
figure;

subplot(3, 2, 1);
imshow(img1, []);
title('Imagem 1: Centro');

subplot(3, 2, 2);
imshow(mag1, []);
title('Espectro 1');

subplot(3, 2, 3);
imshow(img2, []);
title('Imagem 2: Transladação');

subplot(3, 2, 4);
imshow(mag2, []);
title('Espectro 2');

subplot(3, 2, 5);
imshow(img3, []);
title('Imagem 3: Rotação');

subplot(3, 2, 6);
imshow(mag3, []);
title('Espectro 3');
