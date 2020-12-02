clear all;
close all;

FID = fopen('iris.txt');
textdata = textscan(FID,'%f %f %f %f %s', 200, 'Delimiter',',');

%form the data matrix
data = cell2mat(textdata(:,1:4));
target=textdata{1,5};
[m,n] = size(target);
tr=[];

%form the target matrix
for k= 1:m
    a=target(k);
    if strcmp(a,'Iris-setosa')==1
        l=-1;
    elseif strcmp(a,'Iris-versicolor')==1
        l=0;
    else
        l=1;
    end
    tr=[tr;l];
end
clear a;

if max(abs(data(:)))> 1
    %Hay que normalizar
    data = data / max(abs(data(:)));
else
    data = data;
end
data = data.';
tr = tr.';
tr = tr +2;
%W = fisher(data,tr,2);
%red_data = W*data;
red_data = [data', tr'];

%formar conjunto de datos de entrenamiento y test
data_tr=[red_data(1:40,:);red_data(51:90,:);red_data(101:140,:)];
data_test=[red_data(41:50,:);red_data(91:100,:);red_data(141:150,:)];

dimension = 3;
iteraciones = 1500;
alpha = 0.5;
radio = 5;
w = randtop(dimension, dimension);
vecindad = linkdist(w);
w(1,:)= w(1,:)/dimension;
w(2,:) = w(2,:)/dimension-mean(w(2,:));

w = KOHONENtrain(red_data, w, iteraciones, vecindad, alpha, radio,0);

red_data = W*X(:,1:50);
clase1 = KOHNENval(red_data,w);
hold on;
plot(w(1,clase1),w(2,clase1), 'k*');
red_data = W*X(:,51:100);
clase2 = KOHNENval(red_data,w);
plot(w(1,clase2),w(2,clase2), 'm*');
red_data = W*X(:,101:150);
clase3 = KOHNENval(red_data,w);
plot(w(1,clase3),w(2,clase3 ), 'c*');
legend('muestra','enlaces', 'neuronas', 'clase 1', 'clase 2', 'clase 3');