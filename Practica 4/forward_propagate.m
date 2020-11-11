function outputs = forward_propagate(network, row)
%row is input for network
inputs=row;
%hidden layer
new_inputs = double.empty;
for neuron_index = 1:(size(network.hidden_layer,2))
    activation = activar(network.hidden_layer(:,neuron_index), inputs);
    new_inputs = [new_inputs transfer(activation)];
end
inputs = new_inputs;
%output layer
outputs = double.empty;
for neuron_index = 1:(size(network.output_layer,2))
    activation = activar(network.output_layer(:,neuron_index), inputs);
    new_inputs = [new_inputs transfer(activation)];
end
outputs = new_inputs;
end
