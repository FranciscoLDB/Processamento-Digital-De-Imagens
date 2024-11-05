% 5.1) MSSIM image quality metric (IQM)

close all; clear; clc;

% Carregar as imagens
original = imread('einstein.gif');
image1 = imread('blur.gif');
image2 = imread('contrast.gif');
image3 = imread('impulse.gif');
image4 = imread('jpg.gif');
image5 = imread('meanshift.gif');

% Calcular MSE e SSIM para cada imagem
images = {image1, image2, image3, image4, image5};
mse_values = zeros(1, 5);
ssim_values = zeros(1, 5);

for i = 1:5
    mse_values(i) = immse(original, images{i});
    ssim_values(i) = ssim(original, images{i});
end

% Exibir os resultados
for i = 1:5
    fprintf('Imagem %d: MSE = %.4f, SSIM = %.4f\n', i, mse_values(i), ssim_values(i));
end

% Imagem 1: MSE = 143.9085, SSIM = 0.7022
% Imagem 2: MSE = 144.2188, SSIM = 0.9012
% Imagem 3: MSE = 143.9390, SSIM = 0.8395
% Imagem 4: MSE = 141.9529, SSIM = 0.6699
% Imagem 5: MSE = 143.9945, SSIM = 0.9873

% 1. A ‘Demonstration’ foi reproduzida com sucesso?
% (c) Sim. Embora os resultados possam não ser numericamente idênticos, 
% são muitíssimos parecidos. 

% 2. Por que o índice SSIM é melhor que o MSE neste experimento?
% (b) Porque o MSE apresenta valores praticamente iguais para qualidades 
% notavelmente diferentes das imagens, enquanto o SSIM captura essas 
% diferenças, além de apresentar valores compatíveis com a noção de 
% qualidade que seria atribuída por uma pessoa (SVH).