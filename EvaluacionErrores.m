clear all, close all

entrenamiento = 0.5; %porcentaje de datos entrenamiento
test = 1-entrenamiento; %porcentaje de datos test


NUMPOINTS=10000; % cantidad de muestras
x = 4*(rand(1,NUMPOINTS)-0.5);
yok = 1.8*tanh(3.2*x + 0.8)- 2.5*tanh(2.1*x + 1.2)- 0.2*tanh(0.1*x - 0.5);
RUIDO = 0.2*std(yok);
yruido = RUIDO*randn(size(yok));
y = yok + yruido;
%figure, plot(x,y,'.b'); 
%hold,plot(x,yok,'.k'); 
%drawnow;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Como se comportan el error empirico y el error de generalizacion respecto
% a el tamano de la muestra?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


E = yok-y;
emp = 1:(NUMPOINTS*entrenamiento);
for i=1:(NUMPOINTS*entrenamiento)
    MSEC = 0;
    for j = 1:i
        MSEC=MSEC + E(j)*E(j);
    end
    MSEC=MSEC/i;
    emp(i)= MSEC;
end
hold,plot(emp);

cantidadMuestrasTest = (NUMPOINTS*test);

generalizationError = 1:(NUMPOINTS*test);
for iNuevo=(NUMPOINTS*entrenamiento):NUMPOINTS
    MSEV = 0;
    for jNuevo = (NUMPOINTS*entrenamiento):iNuevo
        MSEV=MSEV + E(jNuevo)*E(jNuevo);
    end
    MSEV=MSEV/(iNuevo-(NUMPOINTS*entrenamiento-1));
    generalizationError(iNuevo-(NUMPOINTS*entrenamiento-1))= MSEV;
end
plot(generalizationError), legend("Empirical Error","Generalization Error");


% executando el parte anterior se ve que los dos errores se acercan cuando
% el tamano de la muestra cesca.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nueva parte para averiguar que grado debe tener el polinomio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all, close all


entrenamiento = 0.5; %porcentaje de datos entrenamiento
test = 1-entrenamiento; %porcentaje de datos test


NUMPOINTS=1000; % cantidad de muestras
x = 4*(rand(1,NUMPOINTS)-0.5);
yok = 1.8*tanh(3.2*x + 0.8)- 2.5*tanh(2.1*x + 1.2)- 0.2*tanh(0.1*x - 0.5);
RUIDO = 0.2*std(yok);
yruido = RUIDO*randn(size(yok));
y = yok + yruido;



emp=2:15;
gen=2:15;
for grado = 2:15
    coeficientes = polyfit(x,y,grado);
    yPol=polyval(coeficientes,x); 
    %figure
    %hold, plot(x,yPol,"o");

    E = yPol-y;
    MSEC = 0;
    MSEV = 0;
    for i=1:(NUMPOINTS*entrenamiento)   
        MSEC=MSEC + E(i)*E(i);
        MSEC=MSEC/i;
    end
    emp(grado-1)=MSEC;

    for i=(NUMPOINTS*entrenamiento):NUMPOINTS
        MSEV=MSEV + E(i)*E(i);
        MSEV=MSEV/(i-(NUMPOINTS*entrenamiento-1));
    end
    gen(grado-1)=MSEV;

end
hold, plot(2:15,emp);
plot(2:15,gen), legend("Empirical Error","Generalization Error");

%executando esto se ve que un polinomio de grado 5 seria la mejor eleccion,
%porque ambos errores son super bajos.
