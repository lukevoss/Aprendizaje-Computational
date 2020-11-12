function [network] = backward_propagate_error(network, expected)
    fields = fieldnames(network);
    N = length(fields);
    for i = N:-1:1 %Go Backwards through network with subtracting i from N
        layer = network.(fields{i});
        errors = double.empty;
        if i ~= N
            for j = 1:size(layer.weights,1)%count of neurons in this layer
                error = 0.0;
                layer2 = network.(fields{i+1});
                for neuron = 1:size(layer2.weights,1)
                    error = error + ((layer2.weights(neuron, j))*(layer2.delta(neuron)));
                end
                errors = [errors error];
            end
        else
            for j = 1:size(layer.weights,1)
                errors = [errors (expected(j) - layer.output(j))];
            end
        end
        for j = 1:size(layer.weights,1)
            layer.delta(j) = errors(j) * transfer_derivative(layer.output(j));
        end
        network.(fields{i})= layer;
    end
end

