close all
x=[-4:0.1:4];
y=sin(x).*sin(2*x);

ruido=std(y)*0.2;

xtest=rand(1,5000)*8-4;
ytest=sin(xtest).*sin(2*xtest)+randn(1,5000)*ruido;

Ntrain=100;
xtrain=rand(1,Ntrain)*8-4;
ytrain=sin(xtrain).*sin(2*xtrain)+randn(1,Ntrain)*ruido;

plot(x,y,'LineWidth',2),hold on
plot(xtrain,ytrain,'*r','LineWidth',2),grid
legend('Hipotesis','Datos')
set(gca,'FontSize',12)
pause


ErrorCV=zeros(1,20);
ErrorG=zeros(1,20);
ErrorE=zeros(1,20);
for i=1:25
  
  p=polyfit(xtrain,ytrain,i);
  ErrorG(i)=ecm(ytest-polyval(p,xtest));
  ErrorE(i)=ecm(ytrain-polyval(p,xtrain));
  
  ErrorCV(i)=fcross(i,xtrain,ytrain,10);

end
figure,plot(log(ErrorCV),'LineWidth',3),hold on
plot(log(ErrorG),'r','LineWidth',3)
plot(log(ErrorE),'g','LineWidth',3)
xlabel('Complejidad','Fontsize',18)
ylabel('log(error)','Fontsize',18)
legend('Error 10-CV','EG','EE')
set(gca,'FontSize',12)
grid
