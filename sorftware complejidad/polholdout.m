function ERROR=polholdout(xDATA,yDATA,NUMVECES,MODELO)
%
%function ERROR=polholdout(xDATA,yDATA,NUMVECES,MODELO)
%
% Estimacion del error de generalizacion mediante el metodo de HOLDOUT. Se utilizan 2/3 de los datos
% para  entrenar y 1/3 para validar.
%
%Entradas: 
%       xDATA,yDATA:Datos de entrenamiento
%       NUMVECES   : veces que se va a repetir el holdout
%       MODELO     : Grado el Polinomio
%      
%
%Salida:
%      ERROR  : Es el error de HOLDOUT
%
%Ultima modificacion 15/5/02


error   = 0;
[bas,N] = size(xDATA);
n       = round(2*N/3);


for rep=1:NUMVECES
    aux       = randn(1,N);
    [aux,INDICES]=sort(aux);
    xtrain    = xDATA(:,INDICES(1:n));
    ytrain    = yDATA(:,INDICES(1:n));
    xtest     = xDATA(:,INDICES(n+1:N));
    ytest     = yDATA(:,INDICES(n+1:N));
    
    p         = polyfit(xtrain,ytrain,MODELO);
    error     = error + ecm(ytest-polyval(p,xtest));
end

ERROR = error/NUMVECES;


