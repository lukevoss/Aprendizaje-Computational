close all
clear all

%analizar el número óptimo de clústeres
Wines = importdata('wine.data');
Data = Wines(:,2:14);
%for i = 1:size(Data,2) %columnas
%    Data(:,i) = (Data(:,i) - mean((Data(:,i)).')/std((Data(:,i)).'));
%end
sa = [];
K = [];
for i = 1:20
    [idx,c,sumd] = kmeans(Data, i);
    sa = [sa,sum(sumd)];
    K = [K,i];
end
plot(K, sa)


%hacer el clustering

plot(Wines(:,1)), hold on
[idx,c,sumd] = kmeans(Data, 3);
plot(idx,'.')

% Se ve que el clustering aun se puede mejorar. Tal vez deberiamos quitar
% unos datos. Primero vamos a ver la distribucion de cada atributo.
subplot(2,1,1)
boxplot(Wines(:,2),Wines(:,1))
subplot(2,1,2)
boxplot(Wines(:,3),Wines(:,1))


for i = 2:14
    subplot(14,1,i);
    boxplot(Wines(:,i),Wines(:,1))
end
