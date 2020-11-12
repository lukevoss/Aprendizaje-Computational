function [network] = update_weights(network, row, l_rate)
    fields = fieldnames(network);
    N = length(fields);
    for i = 1:N %iterate through layers
        inputs = row[1:length(row)-1];
        if i ~= 1
            inputs = network.(fields{i-1}).output;
        end
        layer = network.(fields{i});
        N_neurons = size(layer.weights, 1)
        for neuron = 1:N_neurons
            for j = 1:length(inputs)
                layer.weights(neuron, j) = layer.weights(neuron, j) + (l_rate * layer.delta(neuron) * inputs(j));
            end
            layer.weights(neuron, N_neurons) = layer.weights(neuron, N_neurons) + (l_rate * layer.delta(neuron));
        end
    end
        
end

