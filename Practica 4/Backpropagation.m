%Load data

Wines = importdata('wine.data');
%Bank = readtable('bank-full.csv','Headerlines',1);
%BankTest = readtable('bank.csv','Headerlines',1);

%initialize Network

red = initialize_network(size(Wines,2),5,3);
red = train_network(red,Wines,0.3,500,3,14);





