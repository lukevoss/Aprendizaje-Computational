close all
clear all

[x,t] = wine_dataset;
data = x';
data = data(:,1:2);

[idx,C] = kmeans(data,3);

figure, hold on
plot(data(idx==1,1),data(idx==1,2),'m.','MarkerSize',12)
plot(data(idx==2,1),data(idx==2,2),'c.','MarkerSize',12)
plot(data(idx==3,1),data(idx==3,2),'g.','MarkerSize',12)
plot(C(1,1),C(1,2),'rx','MarkerSize',15,'LineWidth',3)
plot(C(2,1),C(2,2),'bx','MarkerSize',15,'LineWidth',3)
plot(C(3,1),C(3,2),'kx','MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','Cluster 3','Centroid 1','Centroid 2','Centroid 3','Location','NW')
title 'Clusters and Centroids'
xlabel 'Alcohol'
ylabel 'Malic Acid'
hold off