%Load data

Wines = importdata('wine.data');
%Bank = readtable('bank-full.csv','Headerlines',1);
%BankTest = readtable('bank.csv','Headerlines',1);

min_max = minmax(Wines');
colmin = min_max(1:13,1)';
colmax = min_max(1:13,2)';
Wines_normalized = rescale(Wines(:,1:13),'InputMin', colmin, 'InputMax', colmax);
Wines_normalized(:,14) = Wines(:,14)
%initialize Network

red = initialize_network(size(Wines,2)-1,16,3);
red = train_network(red,Wines,0.9,40,3,14);

red = initialize_network(13,13,3);
red = train_network(red,Wines_normalized,0.2,1000,3,14);


Wine1 = Wines_normalized(1,:);
Wine2 = Wines_normalized (90,:);
Wine3 = Wines_normalized(178,:);


