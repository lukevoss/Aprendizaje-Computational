% A) DETERMINACION DE LOS DATOS DE ENTRENAMIENTO
% ==============================================
 NPATRONES = 100;
 NOCULTAS = 10;
 RUIDO = 1.0;
 patrones = rand(1,NPATRONES) * (5*pi);
 salidas = sinc(patrones)+ RUIDO *randn(1,NPATRONES);
% B) ENTRENAMIENTO DE LA RBF
% ==========================
 centros=kmeans(patrones,NOCULTAS);
 anchura = (max(centros)-min(centros)) /(sqrt(2*NOCULTAS));
 W = rbftrain(patrones,salidas,centros,anchura);
% C) COMPROBACION DEL FUNCIONAMIENTO DE LA RED
% ============================================
 datos_test = linspace(0,5*pi,500);
 salida_real = sinc(datos_test);
 salida_RBF = rbfval(datos_test,centros,anchura,W);
 plot(datos_test,salida_real,'r');hold on;
 plot(datos_test,salida_RBF,'g');hold off;