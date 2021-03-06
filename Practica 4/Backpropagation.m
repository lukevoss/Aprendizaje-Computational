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

%minmax Scaling Bank
min_max = minmax(Bank');
colmin = min_max(1:end-1,1)';
colmax = min_max(1:end-1,2)';
x_Bank = rescale(Bank(:,1:end-1),'InputMin', colmin, 'InputMax', colmax);
y_Bank = Bank(:,end);

%minmax Scaling Wines
min_max = minmax(Wines');
colmin = min_max(1:13,1)'; 
colmax = min_max(1:13,2)';
x_Wines = rescale(Wines(:,1:13),'InputMin', colmin, 'InputMax', colmax);
y_Wines = Wines(:,14);

%Partial Component Analysis
[coeff,~,~,~,explained,~] = pca(x_Bank);
disp("Percentaje para usar solo las primer 13 variables:")
disp(sum(explained(1:13))) 
coeff = coeff(1:13,:);
x_Bank = coeff*x_Bank'; %reduccion de dimensionalidad
x_Bank = x_Bank';

%crear matiz:
Bank = x_Bank;
Bank(:,end+1) = y_Bank;

Wines = x_Wines;
Wines(:,end+1) = y_Wines;


%initialize Network
red_Wines = initialize_network(13,13,3);
%red_Bank = initialize_network(13,13,2);

%entrenamiento de red neuronal Wines
red_Wines = train_network(red_Wines,Wines,0.2,1000,3,14);

%entrenamiento de red neuronal Bank con muestras aleatorias
%y stochastic gradient descend:
% for i= 1:500 
%     idx = randi(size(Bank,1),1000,1);
%     Bank_rand = Bank(idx,:);%randomly select 100 Datapoint and train with them
%     red_Bank = train_network(red_Bank,Bank_rand,0.6,100,2,size(Bank,2));
% end

Wine1 = Wines(1,:);
Wine2 = Wines(90,:);
Wine3 = Wines(178,:);

Bank1 = Bank(1, 1:13);
Bank2_1 = Bank(39657,1:13);
Bank2_2 = Bank(131,1:13);

predict(red_Wines, Wine1);
predict(red_Wines, Wine2);
predict(red_Wines, Wine3);

% for i = 1:5000
%     guess = predict(red_Bank, Bank(i,1:end-1));
%     if guess(1)>= 0,5
%         guessed(i,1) = 1;
%     else
%         guessed(i,1) = 2;
%     end
% end
% expected = Bank(1:5000, 14);
% errors = sum(abs(expected-guessed));


