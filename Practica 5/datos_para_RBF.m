clear
close all

x   = (-4:0.01:4);    			
yok = sin(x).*sin(2*x);
ruido=std(yok);

%dibujo de la funcion y=sin(x)sin(2x)
figure(1)
NDATA=10000;
Xtrain = 8*rand(1,NDATA)-4;
Xtrain = sort(Xtrain);
Ytrain=sin(Xtrain).*sin(2*Xtrain)+0.6*ruido*randn(1,NDATA);
plot(Xtrain,Ytrain,'o');hold on
plot(x,yok,'.k')
xlabel('x');
ylabel('y=sin(x)sin(2x)');
axis([-4,4,-2,2]);
hold off
grid


 NPATRONES = 100;
 NOCULTAS = 10;

% B) ENTRENAMIENTO DE LA RBF
% ==========================
 [idx,centros]=kmedoids(Xtrain',NOCULTAS);
 centros = centros'; %make row vector
 sigma = (max(centros)-min(centros)) /(sqrt(2*NOCULTAS));
 sigma = sigma*ones(1, NOCULTAS);
 W = rbftrain(Xtrain,Ytrain,centros,sigma);
% C) COMPROBACION DEL FUNCIONAMIENTO DE LA RED
% ============================================
 datos_test = 8*rand(1,NDATA)-4;
 datos_test = sort(datos_test)
 salida_real = sin(datos_test).*sin(2*datos_test);
 salida_RBF = rbfval(datos_test,centros,sigma,W);
 plot(datos_test,salida_real);hold on;
 plot(datos_test,salida_RBF);
 
 %Mahalanobis distance:
[idx,centros]=kmedoids(Xtrain',NOCULTAS, 'Distance', 'mahalanobis');
centros = centros'; %make row vector
sigma = (max(centros)-min(centros)) /(sqrt(2*NOCULTAS));
sigma = sigma*ones(1, NOCULTAS);
W = rbftrain(Xtrain,Ytrain,centros,sigma);
salida_RBF_mahal = rbfval(datos_test,centros,sigma,W);
plot(datos_test,salida_RBF_mahal,'b');

%Cityblock distance:
[idx,centros]=kmedoids(Xtrain',NOCULTAS, 'Distance', 'cityblock');
centros = centros'; %make row vector
sigma = (max(centros)-min(centros)) /(sqrt(2*NOCULTAS));
sigma = sigma*ones(1, NOCULTAS);
W = rbftrain(Xtrain,Ytrain,centros,sigma);

salida_RBF_city = rbfval(datos_test,centros,sigma,W);
plot(datos_test,salida_RBF_city,'y');

%Minkowski distance:
[idx,centros]=kmedoids(Xtrain',NOCULTAS, 'Distance', 'minkowski');
centros = centros'; %make row vector
sigma = (max(centros)-min(centros)) /(sqrt(2*NOCULTAS));
sigma = sigma*ones(1, NOCULTAS);
W = rbftrain(Xtrain,Ytrain,centros,sigma);

salida_RBF_mink = rbfval(datos_test,centros,sigma,W);
plot(datos_test,salida_RBF_mink,'m');



legend('sin(x)sin(2x)','Euclidean Distance','Mahalanobis Distance', 'Cityblock Distance', 'Minkowski Distance');
hold off;
 
 
 

