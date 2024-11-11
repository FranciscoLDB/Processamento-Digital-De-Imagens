% 6.3) Transformada de Hough (HT)

close all; clear; clc;

img = imread('sticknote_gray_01.png');

% Detecção de bordas usando o método Canny com parametrização do sigma
sigma = 2;
edges = edge(img, 'Canny', [], sigma);

% Transformada de Hough
[H, theta, rho] = hough(edges);

% Encontrar os picos na matriz Hough
num_peaks = 4;
peaks = houghpeaks(H, num_peaks);

% Encontrar as linhas correspondentes aos picos
lines = houghlines(edges, theta, rho, peaks);

% Exibição das imagens
figure;
subplot(1,2,1), imshow(img), title('Original');
subplot(1,2,2), imshow(edges), title('Detecção de Bordas (Canny)');

figure;
imshow(img), title('Linhas Detectadas');
hold on;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'green');
    
    % Plotar os pontos inicial e final
    plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color', 'yellow');
    plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color', 'red');
end
hold off;