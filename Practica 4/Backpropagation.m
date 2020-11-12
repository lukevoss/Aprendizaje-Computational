%Load data

Wines = importdata('wine.data');
%Bank = readtable('bank-full.csv','Headerlines',1);
%BankTest = readtable('bank.csv','Headerlines',1);

%initialize Network

red = initialize_network(size(Wines,2)-1,16,3);
red = train_network(red,Wines,0.9,40,3,14);





