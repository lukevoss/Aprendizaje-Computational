clc
clear all
close all

%% Cargar conjunto de datos:
filename = 'breast-cancer-wisconsin.data';
delimiter = ',';
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
data = [dataArray{2:end}];
clearvars filename delimiter formatSpec fileID dataArray ans;

%% Preprocesimiento de los datos:

%1. Normalizar Datos:
data = normalize(data, 'range', [-1 1]);
Y = data(:,1);
X = data(:,2:14);


%2. Pricipal Component Analysis:
[coeff, X,~,~,explained] = pca (X);
percentage = sum(explained(1:12)); %Percentage: >99%
X = X(:,1:12);
data = [X,Y];
