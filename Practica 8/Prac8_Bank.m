close all
clear all

filename = 'bank_mod.csv';
delimiter = ';';
formatSpec = '%f%C%C%C%C%f%C%C%C%f%C%f%f%f%f%C%C%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);


bank = table(dataArray{1:end-1}, 'VariableNames', {'age','job','marital','education','default','balance','housing','loan','contact', ...
                                                  'day','month','duration','campaign','pdays','previous','poutcome','y'});
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

bank = table2array(bank);

% data = normalize(bank, 'range', [-1 1]);
% x = data(:,1:16);
% y = data(:,17);
% [idx,C] = kmeans(x,2);

x = cat(2,bank(:,1),bank(:,6));
% y = bank(:,17);
[idx,C] = kmeans(x,2);

% disp(C);

figure, hold on
plot(x(idx==1,1),x(idx==1,2),'m.','MarkerSize',12)
plot(x(idx==2,1),x(idx==2,2),'c.','MarkerSize',12)
plot(C(1,1),C(1,2),'rx','MarkerSize',15,'LineWidth',3)
plot(C(2,1),C(2,2),'bx','MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','Centroid 1','Centroid 2','Location','NW')
title 'Clusters and Centroids'
xlabel 'Age'
ylabel 'Balance'
hold off