% Resposta:
% Os 'buracos' aparecem na imagem rotacionada devido ao problema de
% sobreposição de pixel do forward mapping, pois na hora que vai
% transformar o pixel original, mais de um pixel pode acabar ocupando a
% mesma posição.

close all; clear all; clc;

G = imread('cameraman.tif');

nr = size(G,1);
nc = size(G,2);
[X,Y] = meshgrid(1:nr,1:nc);

N = nr*nc;
I = [X(:)'; 
    Y(:)'; 
    ones(1,N)];

ang = 30*pi/180;

T = [ cos(ang) sin(ang) 0;
    -sin(ang) cos(ang) 0;
    0 0 1];

K = T*I;
temp1 = min(K, [], 2);
m = repmat(temp1, 1, N);
temp2 = K - m;
Kadj = 1 + floor(temp2);
nrOut = max(Kadj(1,:));
ncOut = max(Kadj(2,:));
Gout = uint8(zeros(nrOut, ncOut));

for k = 1:length(Kadj)
 Gout(Kadj(1,k), Kadj(2,k)) = G(I(1,k), I(2,k));
end

imshow(Gout);
