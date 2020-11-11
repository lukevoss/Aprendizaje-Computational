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

%por la regla del "elbow" se ve que 3 seria el numero adequado de clusters.

%hacer el clustering
figure('Name',"Data not modified yet")
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
    figure(i-1);
    boxplot(Wines(:,i),Wines(:,1))
    title(['Attribute ', num2str(i-1)]);
end

%se ve que attributo 3,4 y 5 no sirven mucho. A ver si ayuda quitarlas del
%entrenamiento.

DataFiltered = Wines(:,2);
DataFiltered(:,2:10) = Wines(:,6:14);

figure('Name',"Data Filtered First Time");
plot(Wines(:,1)), hold on
[idx,c,sumd] = kmeans(DataFiltered, 3);
plot(idx,'.')

% se ve bien, que k-means puede distinguir bien entre el primero y el
% segundo vino, pero hay algun problema con el tercero. Volveremos a ver
% los Boxplot. Ahi vemos,que el atributo 7 puede ayudar distinguir entre
% vino 1 y 3 y los atributos 11 y 12 entre vino 2 y 3. Por esto los vamos a
% meter dos veces en los datos de entrenamiento para darles un peso mas
% grande en la calculacion.

DataFiltered(:,11) = Wines(:,8);
DataFiltered(:,12:13) = Wines(:,12:13);
figure('Name',"Data Filtered Second Time");
plot(Wines(:,1)), hold on
[idx,c,sumd] = kmeans(DataFiltered, 3);
plot(idx,'.')

%desfortunadamente no veamos ninguna diferencia. Tal vez no se puede
%aumentar el peso de una muesto por ponerla mas veces. Ahora vamos a tomar
%medidas un poco mas radicales. Como visto en los boxplot el Attributo 7
%era lo que puede ayudarnos mas en distinguir entre los vinos. A ver que
%pasa si usamos K-means solamente con esto:

testTrainingData=Wines(:,8);
figure('Name',"Test with only Attribute Nr 7");
plot(Wines(:,1)), hold on
[idx] = kmeans(testTrainingData, 3);
plot(idx,'.')

% por ahora me parece el mejor resultado. Cada vez que se combina el 7 con
% otro atributo se esta empeorando el resultado del clustering. 
    
   