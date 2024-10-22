% 3.1) Funções de transformação dos níveis de cinza (sigmoide usando intlut)

close all; clear all; clc;

%Sigmoid
%Aloca uint8
%para depois usar funcao intlut (y1 é a LUT)
%Equação da sigmoide
slope = 0.05;
inflec = 127;
x = 0:1:255;
y1 = 1./(1 + exp(-slope*(x - inflec)));
y1n = mat2gray(y1);
y1n = uint8(y1n.*255);
%Display
figure, plot(y1n)
xlim([0 255]), ylim([0 255])
grid on
title('Sigmoide')
xlabel('x'), ylabel('y')

img = imread("vpfig.png");
figure; imshow(img)
imgX = intlut(img, y1n);
figure, imshow(imgX)
title("slope 0.05");

slope2 = 0.30;
y2 = 1./(1 + exp(-slope2*(x - inflec)));
y2n = mat2gray(y2);
y2n = uint8(y2n.*255);

imgX2 = intlut(img, y2n);
figure, imshow(imgX2)
title("slope 0.30");

slope3 = 0.70;
y3 = 1./(1 + exp(-slope3*(x - inflec)));
y3n = mat2gray(y3);
y3n = uint8(y3n.*255);

imgX3 = intlut(img, y3n);
figure, imshow(imgX3)
title("slope 0.70");

