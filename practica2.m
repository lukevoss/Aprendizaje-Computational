%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Practica 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% creating sample data
clear all;
close all;
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
maxgrado = 20;
crossvalError=[2:maxgrado];
for grado = 2:maxgrado
    crossvalError(grado-1)=fcross(grado,x,y,k);
end
plot(2:maxgrado,crossvalError),xlabel("grado"),ylabel("Error"), 
legend("Cross Validation");


% other sample data, where you can presume an increase in variance with
% grade of polynom increasing

clear all;
close all;
rand('seed',0);
randn('seed',0);
clear
clc
N = 1000;
x = 4*(rand(1,N)-0.5);
yok = 2*x.^4+5+3*x;
RUIDO = 2.8*std(yok);
yruido = RUIDO*randn(size(yok));
y= yok + yruido;

% k-CV, Bootstrap
k = 10;
maxgrado = 20;
xAxis = [1:maxgrado];
crossvalError = zeros(1,maxgrado);  %[2:maxgrado]
bootError = zeros(1,maxgrado);   %[2:maxgrado];
for grado = 1:maxgrado
    crossvalError(grado) = fcross(grado,x,y,k);
end
plot(xAxis,crossvalError),xlabel("grado"),ylabel("Error"), 
legend("Cross Validation");


    


%plot(2:maxgrado, bootError), legend ("Bootstrap");


