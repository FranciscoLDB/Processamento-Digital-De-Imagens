clear, clc, close all

load resultado.mat; % resultado.mat é a saída do seu algoritmo
saidaAlgoritmo = resultado;

gabarito = [
3 3 3 3 3;%hanoi_01_01
2 3 3 3 3;%hanoi_01_02
2 1 1 3 3;%hanoi_01_04
2 3 1 2 3;%hanoi_01_06
1 2 2 3 1;%hanoi_01_08
1 3 3 1 2;%hanoi_01_10
3 3 1 2 2;%hanoi_01_13
1 2 3 2 1;%hanoi_01_16
1 2 3 3 1;%hanoi_01_17
3 2 3 3 1;%hanoi_01_18
3 2 3 1 1;%hanoi_01_20
3 1 3 1 1;%hanoi_01_21
3 1 2 2 2;%hanoi_01_23
2 3 2 2 2;%hanoi_01_25
3 3 2 1 2;%hanoi_01_26
3 3 1 1 2;%hanoi_01_27
1 1 1 1 1;%hanoi_01_29
2 2 2 2 1;%hanoi_01_30
1 3 2 3 1;%hanoi_01_33
1 3 3 3 1;%hanoi_01_35
];

errado = abs(saidaAlgoritmo - gabarito);
errado = logical(sum(errado, 2));
certo = ~errado;