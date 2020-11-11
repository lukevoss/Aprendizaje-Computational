function [w, salida, error] = perceptron(w, entrada, target)
    salida = hardlims(entrada' * w);
    error = target - salida;
    %solo se modifican los pesos si hay error
    if error ~= 0
        w = w + error * entrada;
    end
end