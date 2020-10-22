close all
clear all

MODELOS=50;
COMPLEJIDAD=2:MODELOS+1;
Ntrain=300;
Ntest=700;

x=[-4:0.1:4];
y=sin(x).*sin(2*x);

ruido=std(y)*0.2;

xtest=rand(1,Ntest)*8-4;
ytest=sin(xtest).*sin(2*xtest)+randn(1,Ntest)*ruido;

xtrain=rand(1,Ntrain)*8-4;
ytrain=sin(xtrain).*sin(2*xtrain)+randn(1,Ntrain)*ruido;


EG       = zeros(1,MODELOS);
EE       = zeros(1,MODELOS);
ECV      = zeros(1,MODELOS);
EBOOT    = zeros(1,MODELOS);
EBOOTCOR = zeros(1,MODELOS);
EAICc    = EE;
FPE      = EE;

for i=1:MODELOS
    p = polyfit(xtrain,ytrain,i);
    EG(i) = ecm(ytest-polyval(p,xtest));
    EE(i) = ecm(ytrain-polyval(p,xtrain));
    ECV(i)= fcross(i,xtrain,ytrain,10);
    
    EBOOT(i)=0;
    bootData = bootdata(xtest, 20);
    for j = 1:20
        helpArray = zeros(1,numel(bootData(:,j)));
        for k = 1:numel(bootData(:,j))
            helpArray(k)=(ytest(bootData(k,j))-polyval(p,xtest((bootData(k,j)))));
        end
        EBOOT(i) = EBOOT(i)+ ecm(helpArray)/20;
    end
        
    EBOOTCOR(i) = 0.368 * EE(i) + 0.632 * EBOOT(i);
    EAICc(i) = log(EE(i)) + (Ntrain + COMPLEJIDAD(i)) ./ (Ntrain - COMPLEJIDAD(i) - 2);
    FPE(i) = EE(i) * (Ntrain + COMPLEJIDAD(i)) ./ (Ntrain - COMPLEJIDAD(i));
end

figure,hold on
plot(log(ECV),'LineWidth',3)
plot(log(EBOOTCOR),'r','LineWidth',3)
plot(EAICc,'y','LineWidth',3)
plot(log(FPE),'g','LineWidth',3)

xlabel('Complejidad','Fontsize',18)
ylabel('log(error)','Fontsize',18)
legend('10-CV','BOOT632','AICc','FPE')
set(gca,'FontSize',12)
grid
