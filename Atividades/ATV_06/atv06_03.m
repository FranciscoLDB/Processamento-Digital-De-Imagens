% 6.3) Transformada de Hough (HT)

% Carregar a imagem em escala de cinza
grayImage = imread('sticknote_gray_01.png');

% Aplicar um filtro Gaussiano para suavizar a imagem
sigma = 2; % Valor do sigma para o filtro Gaussiano
blurredImage = imgaussfilt(grayImage, sigma);

% Detectar bordas usando o detector de Canny com limites ajustados
edges = edge(blurredImage, 'Canny', [0.1 0.3]); % Ajuste os limites conforme necessário

% Aplicar a Transformada de Hough
[H, theta, rho] = hough(edges);

% Encontrar picos na matriz de Hough
numPeaks = 10; % Definir um número maior para capturar mais linhas inicialmente
peaks = houghpeaks(H, numPeaks, 'Threshold', ceil(0.3 * max(H(:))));

% Obter as linhas usando a Transformada de Hough
lines = houghlines(edges, theta, rho, peaks, 'FillGap', 20, 'MinLength', 40);

% Filtrar para obter apenas as 4 linhas mais longas, supondo que essas são as bordas do post-it
if length(lines) > 4
    % Ordenar as linhas por comprimento (do maior para o menor)
    [~, idx] = sort(arrayfun(@(line) norm(line.point1 - line.point2), lines), 'descend');
    lines = lines(idx(1:4)); % Selecionar as 4 maiores
end

% Mostrar a imagem original com as quatro linhas detectadas sobrepostas
figure, imshow(grayImage), hold on
for k = 1:length(lines)
    % Coordenadas da linha
    xy = [lines(k).point1; lines(k).point2];
    
    % Desenhar as linhas ao redor do post-it
    plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'blue');
    % Marcar os pontos inicial e final das linhas
    plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color', 'yellow');
    plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color', 'red');
end
title('Imagem com as quatro linhas detectadas ao redor do post-it')
hold off
