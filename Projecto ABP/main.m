clc
clear all
close all

%% Cargar conjunto de datos:

%%Initialize variables.
filename = 'wdbc.data';
delimiter = ',';

formatSpec = '%f%C%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
wdbc = table(dataArray{1:end-1}, 'VariableNames', {'ID','Diagnosis','VarName3','VarName4','VarName5','VarName6','VarName7','VarName8','VarName9','VarName10','VarName11','VarName12','VarName13','VarName14','VarName15','VarName16','VarName17','VarName18','VarName19','VarName20','VarName21','VarName22','VarName23','VarName24','VarName25','VarName26','VarName27','VarName28','VarName29','VarName30','VarName31','VarName32'});

clearvars filename delimiter formatSpec fileID dataArray ans;

wdbc.Diagnosis = grp2idx(categorical(wdbc.Diagnosis))-1; % 1 = Malignant, 0 = Benign
wdbc = table2array(wdbc);
wdbc = wdbc(:, 2:32);
data = wdbc;

%% Preprocesimiento de los datos:

%1. Normalizar Datos:
data = normalize(data, 'range', [-1 1]);
Y = data(:,1);
X = data(:,2:end);


%2. Pricipal Component Analysis:
[coeff, X,~,~,explained] = pca (X, 'NumComponents', 20);
percentage = sum(explained(1:20)); %Percentage: >99.6%
% printf("")
X = X(:,1:12);
% data = [X,Y];
