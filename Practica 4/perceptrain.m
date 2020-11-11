%calcular entrenamiento de perceptrón
%Salida es el vector de Pesos
function W = perceptrain(X,Y)
    n = size(X,1)+1;
    Want = ones(n);
    W = rand(n,1);
    while ~isequal(Want, W)
        Want = W;
        for i=1:length(Y)
            [W] = perceptron(W, [X(:,i);1], Y(i));
        end
    end
end