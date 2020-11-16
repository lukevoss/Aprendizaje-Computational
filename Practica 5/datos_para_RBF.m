clear
close all

x   = (-4:0.01:4);    			
yok = sin(x).*sin(2*x);
ruido=std(yok);

%dibujo de la funcion y=sin(x)sin(2x)
figure(1)
NDATA=10000;
Xtrain = 8*rand(1,NDATA)-4;
Ytrain=sin(Xtrain).*sin(2*Xtrain)+0.6*ruido*randn(1,NDATA);
plot(Xtrain,Ytrain,'o');hold on
plot(x,yok,'.k')
xlabel('x');
ylabel('y=sin(x)sin(2x)');
axis([-4,4,-2,2]);
hold off
grid



