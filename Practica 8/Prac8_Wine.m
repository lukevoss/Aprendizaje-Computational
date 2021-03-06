close all
clear all

%% Cargar conjunto de datos:
filename = 'wine.data';
delimiter = ',';
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
wine = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

%% Preprocesimiento de los datos:

%1. Normalizar Datos:
wine = normalize(wine, 'range', [-1 1]);
Y = wine(:,1);
X = wine(:,2:14);


%2. Pricipal Component Analysis:
[coeff, X,~,~,explained] = pca (X);
percentage = sum(explained(1:12)); %Percentage: >99%
X = X(:,1:12);
wine = [X,Y];

clearvars X Y
%% Dividir los datos en datos de entrenamiento y datos de prueba
[m,n] = size(wine);
P = 0.80 ;
idx = randperm(m);
wine_train = wine(idx(1:round(P*m)),:); 
wine_test = wine(idx(round(P*m)+1:end),:);

x_train = wine_train(:, 1:end-1);
y_train = wine_train(:, end);
x_test = wine_test(:, 1:end-1);
y_test = wine_test(:, end);

clearvars P m n idx

%% Kmeans:

[idx,C] = kmeans(x_train,3);
prediction = zeros(size(y_test,1),1);
idx = normalize(idx, 'range', [-1 1]);
% using knn to get the labeling of kmeans correct instead of random :
modelo_for_kmeans = fitcknn(x_train,y_train,'NumNeighbors',7,'Standardize',1);
label = predict(modelo_for_kmeans,C);
for i = 1:size(x_test, 1)
    for j = 1:3
        d(j) = sum((C(j,:)-x_test(i,:)).^2).^0.5;
    end
    if d(1) <= d(2) && d(1) <= d(3)
        prediction(i) = label(1);
    elseif d(2) <= d(1) && d(2) <= d(3)
        prediction(i) = label(2);
    else
        prediction(i) = label(3);
    end
end

score_kmeans = 0;
for i = 1:size(y_test,1)
    if prediction(i)== y_test(i)
            score_kmeans = score_kmeans + 1;
    end
end

clearvars C ans d i idx j;
    

% 
% % disp(C);
% figure, hold on
% plot(X(idx==1,1),X(idx==1,2),'m.','MarkerSize',12)
% plot(X(idx==2,1),X(idx==2,2),'c.','MarkerSize',12)
% plot(C(1,1),C(1,2),'rx','MarkerSize',15,'LineWidth',3)
% plot(C(2,1),C(2,2),'bx','MarkerSize',15,'LineWidth',3)
% legend('Cluster 1','Cluster 2','Centroid 1','Centroid 2','Location','NW')
% title 'Clusters and Centroids'
% xlabel 'Age'
% ylabel 'Balance'
% hold off

%% K-Nearest Neighbours

% encontrar un k adequado 
k_best=1;
score_best = 0;
for k = 1:30
    modelo = fitcknn(x_train,y_train,'NumNeighbors',k,'Standardize',1);
    label = predict(modelo,x_test);
    score = 0;
    for i = 1 : size(label)
        if label(i)== y_test(i)
            score = score + 1;
        end
    end
    if score_best < score
        score_best = score;
        k_best = k;
    end
end
% parece que no hay una gran diferencia por diferentes k, y el mejor k
% varia con cada ejecucion.

%% Clustering Jerárquico

pdist(x_test);

%% Plotear los resultados
scores = [score_best,score_kmeans];
names = categorical({'KNN','Kmeans'});
bar(names,scores)
title('Performance of KNN and Kmeans');
ylabel('correct categorizations out of 36');