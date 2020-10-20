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


EG    = zeros(1,MODELOS);
EE    = zeros(1,MODELOS);
ECV   = zeros(1,MODELOS);
EBOOT = zeros(1,MODELOS);
EAICc = EE;
FPE = EE;

for i=1:MODELOS
    p = polyfit(xtrain,ytrain,i);
    EG(i) = ecm(ytest-polyval(p,xtest));
    EE(i) = ecm(ytrain-polyval(p,xtrain));
    ECV(i)= fcross(i,xtrain,ytrain,10);
    EBOOT(i) = 0.368 * EE(i) + 0.632 * EG(i);
    EAICc(i) = log(EE(i)) + (Ntrain + COMPLEJIDAD(i)) ./ (Ntrain - COMPLEJIDAD(i) - 2);
    FPE(i) = EE(i) * (Ntrain + COMPLEJIDAD(i)) ./ (Ntrain - COMPLEJIDAD(i));
end

figure,hold on
plot(log(ECV),'LineWidth',3)
plot(EBOOT,'r','LineWidth',3)
plot(EAICc,'y','LineWidth',3)
plot(FPE,'g','LineWidth',3)

xlabel('Complejidad','Fontsize',18)
ylabel('log(error)','Fontsize',18)
legend('10-CV','BOOT','AICc','FPE')
set(gca,'FontSize',12)
grid

[kk,model]=min([ECV' EBOOT' EAICc' FPE']);
figure,plot(model,'*r','MarkerSize',12)
set(gca,'Xtick',[0:length(model)])
set(gca,'XtickLabel',{' ','10-CV','BOOT','AICc','FPE',' '})
axis([0,length(model)+1,-1,MODELOS+1])
grid
