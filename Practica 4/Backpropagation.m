%Load data

Wines = importdata('wine.data');
%Bank = readtable('bank-full.csv','Headerlines',1);
%BankTest = readtable('bank.csv','Headerlines',1);

%initialize Network

red = initialize_network(13,13,3);
red = train_network(red,Wines,0.4,50,3,14);


Wine1 = Wines (1,:);
Wine3 = Wines (178,:);


