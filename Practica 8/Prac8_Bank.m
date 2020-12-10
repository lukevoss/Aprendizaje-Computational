close all
clear all

%% Cargar conjunto de datos:
filename = 'bank.csv';
delimiter = ';';
startRow = 2;
formatSpec = '%f%C%C%C%C%f%C%C%C%f%C%f%f%f%f%C%C%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
bank = table(dataArray{1:end-1}, 'VariableNames', {'age','job','marital','education','default','balance','housing','loan','contact','day','month','duration','campaign','pdays','previous','poutcome','y'});
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% Preprocesimiento de los datos:

%1. Cambiar string al valor double:
bank.job = grp2idx(categorical(bank.job));
bank.marital = grp2idx(categorical(bank.marital));
bank.education = grp2idx(categorical(bank.education));
bank.default = grp2idx(categorical(bank.default));
bank.housing = grp2idx(categorical(bank.housing));
bank.loan = grp2idx(categorical(bank.loan));
bank.contact = grp2idx(categorical(bank.contact));
bank.month = grp2idx(categorical(bank.month));
bank.poutcome = grp2idx(categorical(bank.poutcome));
bank.y = grp2idx(categorical(bank.y));

%2. Crear Matiz:
bank = table2array(bank);

%3. Normalizar Datos:
bank = normalize(bank, 'range', [-1 1]);
Y = bank(:, end);
X = bank(:, 1:end-1);

%4. Pricipal Component Analysis:
[~, X,~,~,explained] = pca (X);
percentage = sum(explained(1:12)); %percentage = 99%
X = X(:, 1:12);
bank = [X,Y];
clearvars X Y 

%% Dividir los datos en datos de entrenamiento y datos de prueba
[m,n] = size(bank);
P = 0.80 ;
idx = randperm(m);
bank_train = bank(idx(1:round(P*m)),:); 
bank_test = bank(idx(round(P*m)+1:end),:);

x_train = bank_train(:, 1:end-1);
y_train = bank_train(:, end);
x_test = bank_test(:, 1:end-1);
y_test = bank_test(:, end);

clearvars P m n idx

%% Kmeans:

[idx,C] = kmeans(X,2);

% disp(C);
figure, hold on
plot(X(idx==1,1),X(idx==1,2),'m.','MarkerSize',12)
plot(X(idx==2,1),X(idx==2,2),'c.','MarkerSize',12)
plot(C(1,1),C(1,2),'rx','MarkerSize',15,'LineWidth',3)
plot(C(2,1),C(2,2),'bx','MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','Centroid 1','Centroid 2','Location','NW')
title 'Clusters and Centroids'
xlabel 'Age'
ylabel 'Balance'
hold off

%% K-Nearest Neighbours


modelo = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1);
label = predict(modelo,X);