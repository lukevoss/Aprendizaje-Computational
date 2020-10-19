function indicesboot=bootdata(xTrain,KBOOT)
%
% Genera nuestras de BOOTSTRAP
%
% Entrada: xTrain :Datos de entrenamiento
%          KBOOT  : Numero de muestras de Bootstrap
% Salida: indicesboot: Matriz con las posiciones de las muestras.
%
%Ultima modificacion 15/5/02


 N=length(xTrain);
indicesboot=zeros(N,KBOOT); 
 for i=1:KBOOT
        [a,b]=mibootstrp(1,'',xTrain);
        [dummy,resto]=ainb(b,1:length(xTrain));
        while length(resto)<2
            [a,b]=mibootstrp(1,'',xTrain);
            [dummy,resto]=ainb(b,1:length(xTrain));
        end
         indicesboot(:,i)=b;
  end

