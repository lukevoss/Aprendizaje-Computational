close all;
clear all;

filename = 'wine.data';
delimiter = ',';
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
wine = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

%normalize data
wine = normalize(wine, 'range', [-1 1]);

y = wine(:,1);
X = wine(:,2:14);


%Pricipal Component Analysis:
[coeff, X,~,~,explained] = pca (X, 'NumComponents',2);
percentage = sum(explained(1:2));

dimension = 3;
iteraciones = 1500;
alpha = 0.5;
radio = 5;
w = randtop(dimension, dimension);
vecindad = linkdist(w);

%transpose X_train to have x and y value in each column
w = som_train(X', w, iteraciones, vecindad, alpha, radio, 1);
clearvars iteraciones alpha radio dimension;

red_data = X(1:50,:);
clase1 = som_evaluation(red_data',w);
clase1 = unique(clase1);
red_data = X(51:100,:);
clase2 = som_evaluation(red_data',w);
clase2 = unique(clase2);
red_data = X(101:150,:);
clase3 = som_evaluation(red_data',w);
clase3 = unique(clase3);


%Plot
hold on;
plot(w(1, clase3),w(2, clase3), 'c*', 'MarkerSize', 7, 'LineWidth', 1);
plot(w(1, clase2),w(2, clase2), 'm*', 'MarkerSize', 7, 'LineWidth', 1);
plot(w(1, clase1),w(2, clase1), 'k*', 'MarkerSize', 7, 'LineWidth', 1);
legend('muestra','enlaces', 'neuronas', 'class 1', 'class 2', 'class 3');
hold off;
