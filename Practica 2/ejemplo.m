close all
clear all

MODELOS=30;
COMPLEJIDAD=2:MODELOS+1;
Ntrain=100;

x=[-4:0.1:4];
y=sin(x).*sin(2*x);

ruido=std(y)*0.2;

xtest=rand(1,5000)*8-4;
ytest=sin(xtest).*sin(2*xtest)+randn(1,5000)*ruido;

xtrain=rand(1,Ntrain)*8-4;
ytrain=sin(xtrain).*sin(2*xtrain)+randn(1,Ntrain)*ruido;

%plot(x,y,'LineWidth',2),hold on
%plot(xtrain,ytrain,'*r','LineWidth',2),grid
%legend('Hipotesis','Datos')
%set(gca,'FontSize',12)

EG    = zeros(1,MODELOS);
EE    = zeros(1,MODELOS);
ECV   = zeros(1,MODELOS);
EHOLD = EE;
EAICc = EE;

for i=1:MODELOS
  p = polyfit(xtrain,ytrain,i);
  EG(i) = ecm(ytest-polyval(p,xtest));
  EE(i) = ecm(ytrain-polyval(p,xtrain));
  ECV(i)= fcross(i,xtrain,ytrain,10);
  EHOLD(i) = polholdout(xtrain,ytrain,1,i);
  EAICc(i) = log(EE(i))+(Ntrain+COMPLEJIDAD(i))./(Ntrain-COMPLEJIDAD(i)-2);
end

figure,hold on
plot(log(EG),'r','LineWidth',3)
plot(log(EE),'g','LineWidth',3)
plot(log(ECV),'LineWidth',3),
plot(EAICc,'y','LineWidth',3);
plot(log(EHOLD),'m','LineWidth',3);

xlabel('Complejidad','Fontsize',18)
ylabel('log(error)','Fontsize',18)
legend('EG','EE','10-CV','AICc','HOLD')
set(gca,'FontSize',12)
grid

[kk,model]=min([EG' EE' ECV' EAICc' EHOLD']);
figure,plot(model,'*r','MarkerSize',12)
set(gca,'Xtick',[0:length(model)])
set(gca,'XtickLabel',{' ','EG','EE','10CV','AIC','HOLD',' '})
axis([0,length(model)+1,-1,MODELOS+1])
grid


