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

a = 0.5;
r = 6;
dim = 3;
iter = 400;
w = randtop(dim, dim);
v = linkdist(w);

%transpose X_train to have x and y value in each column
w = som_train(X', w, iter, v, a, r);
clearvars iteraciones alpha radio dimension;

red_data = X(1:59,:);
c1 = som_evaluation(red_data',w);
clase1 = unique(c1);
red_data = X(60:130,:);
c2 = som_evaluation(red_data',w);
clase2 = unique(c2);
red_data = X(131:178,:);
c3 = som_evaluation(red_data',w);
clase3 = unique(c3);

%Las clases 2 y 3 est�n muy juntas, por lo que debemos averiguar para 
%cada neurona su clase m�s cercana.
elementos_dobles = intersect(clase3, clase2);
for i = 1: length(elementos_dobles)
    elements_clase2 = sum(c2==elementos_dobles(i));
    elements_clase3 = sum(c3==elementos_dobles(i));
    if (elements_clase3 >= elements_clase2)
        index = find(clase2 == elementos_dobles(i));
        clase2(index)=[];
    else
        index = find(clase3 == elementos_dobles(i));
        clase3(index)=[];
    end
end

%Mismo con las clases 2 y 1
elementos_dobles = intersect(clase2, clase1);
for i = 1: length(elementos_dobles)
    elements_clase2 = sum(c2==elementos_dobles(i));
    elements_clase1 = sum(c1==elementos_dobles(i));
    if (elements_clase1 >= elements_clase2)
        index = find(clase2 == elementos_dobles(i));
        clase2(index)=[];
    else
        index = find(clase1 == elementos_dobles(i));
        clase1(index)=[];
    end
end

%Pruebe qu� tan bien se desempe�a la clasificaci�n
score = 0;
for i = 1:length(c1)
    if (ismember(c1(i),clase1))
        score = score +1;
    end
end
for i = 1:length(c2)
    if (ismember(c2(i),clase2))
        score = score +1;
    end
end
for i = 1:length(c3)
    if (ismember(c3(i),clase3))
        score = score +1;
    end
end

percentage = (score/size(X,1)) * 100;

%Plot
hold on;
plot(w(1, clase3),w(2, clase3), 'b .', 'MarkerSize', 20, 'LineWidth', 1);
plot(w(1, clase2),w(2, clase2), 'k .', 'MarkerSize', 20, 'LineWidth', 1);
plot(w(1, clase1),w(2, clase1), 'y .', 'MarkerSize', 20, 'LineWidth', 1);
legend('muestra','enlaces', 'neuronas', 'class 3', 'class 2', 'class 1');
hold off;
