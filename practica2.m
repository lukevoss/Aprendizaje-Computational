%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Practica 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% creating sample data

rand('seed',0);
randn('seed',0);
clear
clc
N = 1000;
x = 4*(rand(1,N)-0.5);
yok = 1.8*tanh(3.2*x + 0.8)- 2.5*tanh(2.1*x + 1.2)- 0.2*tanh(0.1*x - 0.5);
RUIDO = 0.2*std(yok);
yruido = RUIDO*randn(size(yok));
y= yok + yruido;

% k-CV
k = 10;
crossvalError=[2:15];
for grado = 2:15
    crossvalError(grado-1)=fcross(grado,x,y,k);
end
plot(2:15,crossvalError),xlabel("grado"),ylabel("Error"), legend("Cross Validation");