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

dimension = 3;
iteraciones = 1500;
alpha = 0.5;
radio = 5;
w = randtop(dimension, dimension);
vecindad = linkdist(w);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%colocamos las neuronas en el centro de la muestra
%??/dimensions
% w(1,:)= w(1,:)-mean(w(1,:));
% w(2,:)= w(2,:)-mean(w(2,:));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%transpose X_train to have x and y value in each column
w = KOHONENtrain(X_train', w, iteraciones, vecindad, alpha, radio, 1);

red_data = X(1:50,:);
clase1 = KOHNENval(red_data,w);
hold on;
plot(w(1,clase1),w(2,clase1), 'k*');
red_data = X(51:100,:);
clase2 = KOHNENval(red_data,w);
plot(w(1,clase2),w(2,clase2), 'm*');
red_data = X(101:150,:);
clase3 = KOHNENval(red_data,w);
plot(w(1,clase3),w(2,clase3 ), 'c*');
legend('muestra','enlaces', 'neuronas', 'clase 1', 'clase 2', 'clase 3');
