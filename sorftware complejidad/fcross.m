function Error=fcross(Modelo,xTrain,yTrain,Fold)
%
% function Error=fcross(Modelo,xTrain,yTrain,Fold)
%
% Determina el error de crossvalidación para funciones polinomiales
%
% ENTRADA: Modelo: Complejidad del polinomio
%          xtrain, ytrain :Datos de entrada
%          Fold: Valor de crossvalidación
% SALIDA: Error: Error de crossvalidación
%
%
%Ultima modificacion 15/5/02


  K    = Fold;
  suma = 0; 
  
  for xv=1:K,
      [x1,x2,y1,y2] = crossval(xTrain,yTrain,K,xv);
	  p             = polyfit(x1,y1,Modelo);      
      suma          = suma+ecm(polyval(p,x2)-y2);
  end;
  Error = suma/K;                 

    
