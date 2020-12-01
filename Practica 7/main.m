clear all;
close all;

load('iris.data');

y = [t + 1]';
X=X';
W = fisher(X,y,2);
x = W*X;

dimension = 3;
iteraciones = 1500;
alpha = 0.5;
radio = 5;
w = randtop(dimension, dimension);
vecindad = linkdist(w);
w(1,:)= w(1,:)/dimension;
w(2,:) = w(2,:)/dimension-mean(w(2,:));

w = KOHONENtrain(x, w, iterationes, vecindad, alpha, radio);

x = W*X(:,1:50);
clase1 = KOHNENval(x,w);
hold on;
plot(w(1,clase1),w(2,clase1), 'k*');
x = W*X(:,51:100);
clase2 = KOHNENval(x,w);
plot(w(1,clase2),w(2,clase2), 'm*');
x = W*X(:,101:150);
clase3 = KOHNENval(x,w);
plot(w(1,clase3),w(2,clase3 ), 'c*');
legend('muestra','enlaces', 'neuronas', 'clase 1', 'clase 2', 'clase 3');