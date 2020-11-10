%calcular entrenamiento de perceptrón
%Salida es el vector de Pesos
function W = perceptrain(X,Y)
    Want = [1 1 1];
    W = rand(3,1);
    while ~isequal(Want, W)
        Want = W;
        for i=1:length(Y)
            [W] = perceptron(W, [X(:,i);1], Y(i));
        end
    end
end