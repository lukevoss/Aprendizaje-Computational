clc;
clear all;
close all;

x = [0 0 1; 1 0 1; 0 1 1; 1 1 1];
y = [-1; -1; -1; 1];

w = perc_train(x,y);

plot(x(1,1),x(1,2),'*r','MarkerSize',10); hold on;
plot(x(2,1),x(2,2),'*r','MarkerSize',10); hold on;
plot(x(3,1),x(3,2),'*r','MarkerSize',10); hold on;
plot(x(4,1),x(4,2),'*g','MarkerSize',10); hold on;

t = linspace(-1,2);
plot(t,(-w(1) * t - w(3)) / w(2),'b'); axis([-1 2 -1 2]);