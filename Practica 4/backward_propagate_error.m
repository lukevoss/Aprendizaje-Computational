function [network] = backward_propagate_error(network, expected)
    fields = fieldnames(network);
    for i = numel(fields):1 %Go Backwards through network
        layer = network.(fields{i});
        errors = double.empty;
        if i ~= (length(fields)-1)
            for j = 1:length(layer.weights)%count of neurons in this layer
                error = 0.0;
                layer2 = network.(fields{i+1});
                for neuron = 1:length(layer2.weigths)
                    error = error + (layer2.weights(j)*layer2.delta(j));
                end
                errors = [errors error];    
            end
        else
            for j = 1:length(layer.weights)
                errors = [errors (expected(j) - layer.output(j))]
            end
        end
        for j = 1:length(layer.weights)
            layer.delta(j) = errors(j) * transfer_derivate(layer.output(j))
        end
    end
end
