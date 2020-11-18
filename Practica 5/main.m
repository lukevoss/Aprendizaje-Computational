% A) DETERMINACION DE LOS DATOS DE ENTRENAMIENTO
% ==============================================

Wines = importdata('wine.data');


 NPATRONES = 100;
 NOCULTAS = 10;
 RUIDO = 1.0;
 patrones = rand(1,NPATRONES) * (5*pi);
 salidas = sinc(patrones)+ RUIDO *randn(1,NPATRONES);
 all_data(:,1) = patrones';
 all_data(:,2) = salidas';
% B) ENTRENAMIENTO DE LA RBF
% ==========================
 [idx,centros]=kmeans(patrones',NOCULTAS);
 centros = centros'; %make row vector
 sigma = (max(centros)-min(centros)) /(sqrt(2*NOCULTAS));
 sigma = sigma*ones(1, NOCULTAS);
 W = rbftrain(patrones,salidas,centros,sigma);
% C) COMPROBACION DEL FUNCIONAMIENTO DE LA RED
% ============================================
 datos_test = linspace(0,5*pi,500);
 salida_real = sinc(datos_test);
 salida_RBF = rbfval(datos_test,centros,sigma,W);
 plot(datos_test,salida_real,'r');hold on;
 plot(datos_test,salida_RBF,'g');hold off;