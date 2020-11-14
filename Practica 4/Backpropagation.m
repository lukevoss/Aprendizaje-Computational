%Load data
Wines = importdata('wine.data');
Bank = readtable('Bank-full.csv');
BankTest = readtable('Bank.csv');
complete_Bank = rmmissing(Bank);
Bank = complete_Bank;

%convertir a valores numéricos
Bank.job = grp2idx(categorical(Bank.job));
Bank.marital = grp2idx(categorical(Bank.marital));
Bank.education = grp2idx(categorical(Bank.education));
Bank.default = grp2idx(categorical(Bank.default));
Bank.housing = grp2idx(categorical(Bank.housing));
Bank.loan = grp2idx(categorical(Bank.loan));
Bank.contact = grp2idx(categorical(Bank.contact));
Bank.month = grp2idx(categorical(Bank.month));
Bank.poutcome = grp2idx(categorical(Bank.poutcome));
Bank.y = grp2idx(categorical(Bank.y));

%de tabla a matriz
Bank = table2array(Bank);

min_max = minmax(Bank');
colmin = min_max(1:end-1,1)';
colmax = min_max(1:end-1,2)';
Bank_normalized = rescale(Bank(:,1:end-1),'InputMin', colmin, 'InputMax', colmax);
Bank_normalized(:,end+1) = Bank(:,end)

min_max = minmax(Wines');
colmin = min_max(1:13,1)';
colmax = min_max(1:13,2)';
Wines_normalized = rescale(Wines(:,1:13),'InputMin', colmin, 'InputMax', colmax);
Wines_normalized(:,14) = Wines(:,14)
%initialize Network

%red = initialize_network(13,13,3);
%red = train_network(red,Wines_normalized,0.2,1000,3,14);

red = initialize_network(16,16,2);
red = train_network(red,Bank_normalized,0.3,300,2,17);

Wine1 = Wines_normalized(1,:);
Wine2 = Wines_normalized (90,:);
Wine3 = Wines_normalized(178,:);

Bank1 = Bank_normalized(1, :);
Bank2 = Bank_normalized(39657,:);




