close all;
clear all;

filename = 'iris.data';
delimiter = ',';
formatSpec = '%f%f%f%f%C%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);

iris = table(dataArray{1:end-1}, 'VariableNames', {'sepallength','sepalwidth','petallength','petalwidth','class'});
iris.class = grp2idx(categorical(iris.class));
iris = table2array(iris);

clearvars filename delimiter formatSpec fileID dataArray ans;

%normalize data
iris = normalize(iris, 'range', [-1 1]);

y = iris(:,5);
X = iris(:,1:4);


%Pricipal Component Analysis:
[coeff, X,~,~,explained] = pca (X, 'NumComponents',2);
percentage = sum(explained(1:2));

X_train = [X(1:40,:); X(51:90,:); X(101:140,:)];
y_train = [y(1:40,:); y(51:90,:); y(101:140,:)];
X_test = [X(41:50,:); X(91:100,:); X(141:150,:)];
y_test = [y(41:50,:); y(91:100,:); y(141:150,:)];

dim = 3;
iter = 500;
a = 0.5;
r = 6;
w = randtop(dim, dim);
vecindad = linkdist(w);

%transpose X_train to have x and y value in each column
w = som_train(X_train', w, iter, vecindad, a, r);
clearvars iter a radio dimension;

red_data = X(1:50,:);
c1 = som_evaluation(red_data',w);
clase1 = unique(c1);
red_data = X(51:100,:);
c2 = som_evaluation(red_data',w);
clase2 = unique(c2);
red_data = X(101:150,:);
c3 = som_evaluation(red_data',w);
clase3 = unique(c3);

%clase 2 y clase 3 tienen valores superpuestos, por lo que determinamos 
%para cada clase qué neuronas tienen distancias más cortas
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

%Pruebe qué tan bien se desempeña la clasificación
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
plot(w(1, clase1),w(2, clase1), 'b .', 'MarkerSize', 20, 'LineWidth', 1);
plot(w(1, clase2),w(2, clase2), 'k .', 'MarkerSize', 20, 'LineWidth', 1);
plot(w(1, clase3),w(2, clase3), 'y .', 'MarkerSize', 20, 'LineWidth', 1);
legend('muestra','enlaces', 'neuronas', 'Iris-setosa', 'Iris-versicolor', 'Iris-virginica');
hold off;
