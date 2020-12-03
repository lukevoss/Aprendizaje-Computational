function w = KOHONENtrain(x,w,T,vecindad,alpha0,radio0,plotear)
narginchk(7,7);
% N neuronas en la capa de entrada.
% En funcin de unos patrones con caraccersticas N-dimensìonales
N = size(x,2);
% M neuronas en La capa de salida
M = size(w,2);
distancias = zeros(1,M);
pesos_ant = w;
t = 1;
listo = false;
while t<=T && ~listo 
    % Tasa de aprendizaje se reduce con el n de íteraciones
    alpha = alpha0 * ( 1 - (t / T) );
    radio = round(radio0 * ( 1 - (t / T) ));
    for i=1:N
        % Obtener BMU
        for j=1:M
            distancias(j)=sumsqr(w(:,j)-x(:,i));
        end
        [ ~,BMU]=min(distancias);
        %Modificamos de la BMU y de sus vecinas
        %Calculamos el incremento
        incremento = x(:,i) - w(:,BMU);
        %Lo vectorizamos para porder operar con
        inc = repmat(incremento,1,M);
        omega = zeros(1,M); % iniziamos omega a cero
        %Buscamos los vecinos a una distancia <= radio
        indices = find(vecindad(BMU,:)<=radio);
        for k = indices
            %Optamos por una funcion exponencial
            omega(k)= 1 / exp(vecindad(BMU,k)');
        end
        %Preparamos omega para poder usarlo matricialmente
        omega = repmat(omega,size(w,1),1);
        % Calulamos la variacion donde corresponda
        suma = (alpha * omega .* inc);
        % Se la sumamos a los pesos
        w = w + suma;
    end
    % Si no hay variacln de pesos, terminamos el entrenamiento
    if pesos_ant ~= w
        pesos_ant = w;
    else
        listo = true;
    end
    % Si se desea, podemos observar el entrenamlenno de la red
    if plotear
        figure(1)
        plot(x(1,:),x(2,:),'g.')
        hold on
        plotsom(w(1:2,:)',vecindad);
        title(['Red KOHONEN entrada con t = ',num2str(t)]);
        hold off
        drawnow;
    end
end