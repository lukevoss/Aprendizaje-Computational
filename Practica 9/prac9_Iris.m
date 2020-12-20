clc
clear all
close all

%% Cargar conjunto de datos:
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

%% Preprocesimiento de los datos:

%1. Normalizar Datos:
iris = normalize(iris, 'range', [-1 1]);

Y = iris(:,5);
X = iris(:,1:4);


%2. Pricipal Component Analysis:
[coeff, X,~,~,explained] = pca (X, 'NumComponents',3);
percentage = sum(explained(1:3)); %Percentage: >99%
Iris = [X,Y];


%% hierarchical clustering

% animation of clustering

treefigure1=linkage(X,'ward');
g=unique(treefigure1(:,3));
m=sort(g);
mk=(m>=1);
m=m(mk);
figure;
pause(1);
for i=1:length(m)
    subplot(1,2,1);
    H=dendrogram(treefigure1,'ColorThreshold',m(i));
    set(H,'LineWidth',3)
    c=cluster(treefigure1,'cutoff',m(i),'Criterion','distance');
    subplot(1,2,2);
    gscatter(X(:,1),X(:,2),c);
    if(i==1)
        pause(1);
    else
        pause(0.6);
    end
    if(i~=length(m))
        clf
    end
end

% "finding perfect spot to cut the dendogram"

I=inconsistent(treefigure1,9);
[ax, bx]=max(I(:,4));
cl=cluster(treefigure1,'cutoff',treefigure1(bx-1,3)-0.1,'Criterion','distance');
gscatter(X(:,1),X(:,2),cl);

%% getting accuracy

score = 0;
a = 0;
b = 0;
c = 0;
for i=1:50
    if cl(i) == 1
        a = a + 1;
    elseif cl(i) == 2
        b = b + 1;
    else
        c = c + 1;
    end
end 
score = score + max([a b c]);
a = 0;
b = 0;
c = 0;
for i=51:100
    if cl(i) == 1
        a = a + 1;
    elseif cl(i) == 2
        b = b + 1;
    else
        c = c + 1;
    end
end 
score = score + max([a b c]);
a = 0;
b = 0;
c = 0;
for i=101:150
    if cl(i) == 1
        a = a + 1;
    elseif cl(i) == 2
        b = b + 1;
    else
        c = c + 1;
    end
end 
score = score + max([a b c]);
accuracy = score/length(cl)
    