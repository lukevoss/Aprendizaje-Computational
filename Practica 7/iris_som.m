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
iris = normalize(iris, 'center', 'mean');

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
w = som_train(X_train', w, iter, vecindad, a, r, 1);
clearvars iter a radio dimension;

red_data = X(1:50,:);
clase1 = som_evaluation(red_data',w);
c1 = unique(clase1);
red_data = X(51:100,:);
clase2 = som_evaluation(red_data',w);
c2 = unique(clase2);
red_data = X(101:150,:);
clase3 = som_evaluation(red_data',w);
c3 = unique(clase3);

%clase 2 y clase 3 tienen valores superpuestos, por lo que determinamos 
%para cada clase qué neuronas tienen distancias más cortas
counts2 = zeros(1,length(c2));
for i = 1:length(c2)
    counts2(i) = sum(clase2==c2(i));
end
counts3 = zeros(1,length(c3));
for i = 1:length(c3)
    counts3(i) = sum(clase3==c3(i));
end
new_c2 = [];
new_c3 = [];
for i= 1:length(c2)
    k = find(c3==c2(i));
    if ~isempty(k)
        if counts2(i) > counts3(k)
            new_c2 = [new_c2 c2(i)];
        end
    else 
        new_c2 = [new_c2 c2(i)];
    end
end
c2 = new_c2;
for i = 1:length(c3)
    k = find(c2==c3(i));
    if isempty(k)
        new_c3 = [new_c3 c3(i)];
    end
end
c3= new_c3;
clase1 = c1;
clase2 = c2;
clase3 = c3;
clearvars new_c2 c1 c2 c3 counts2 counts3;


%Plot
hold on;
plot(w(1, clase1),w(2, clase1), 'b o', 'MarkerSize', 7, 'LineWidth', 1);
plot(w(1, clase2),w(2, clase2), 'k o', 'MarkerSize', 7, 'LineWidth', 1);
plot(w(1, clase3),w(2, clase3), 'y o', 'MarkerSize', 7, 'LineWidth', 1);
legend('muestra','enlaces', 'neuronas', 'Iris-setosa', 'Iris-versicolor', 'Iris-virginica');
hold off;
