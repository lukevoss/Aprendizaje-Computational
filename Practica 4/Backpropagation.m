%Load data

Wines = importdata('wine.data');
%Bank = readtable('bank-full.csv','Headerlines',1);
%BankTest = readtable('bank.csv','Headerlines',1);

%initialize Network

<<<<<<< HEAD
red = initialize_network(size(Wines,2)-1,16,3);
red = train_network(red,Wines,0.9,40,3,14);

=======
red = initialize_network(13,13,3);
red = train_network(red,Wines,0.4,50,3,14);
>>>>>>> 3158614f56cc11c3f82f0a534db15f6081d25359


Wine1 = Wines (1,:);
Wine3 = Wines (178,:);


