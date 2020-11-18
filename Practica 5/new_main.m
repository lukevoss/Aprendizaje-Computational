Wines = importdata('wine.data');

Data = (Wines(:,2:14))';
Outputs = (Wines(:,1))';
net = newrb(Data,Outputs,0.03,1);
view(net)
results = sim(net,Data);
x = 1:178;
plot(x,results,'.')