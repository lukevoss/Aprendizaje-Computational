function activation = activar(weights, inputs)
    activation = weights(length(weights)); %Bias
    for i = 1:(length(weights)-1)
        activation = activation + weights(i) * inputs(i);
    end
end
%% pass in weights od neuron as a vector
