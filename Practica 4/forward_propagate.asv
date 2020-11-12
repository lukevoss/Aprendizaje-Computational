function [network, inputs] = forward_propagate(network, row)   
%row is input for network
    inputs=row;
    layers = fieldnames(network);
    for layer_index = 1:numel(layers)

    new_inputs = double.empty;%for speed purposes should be preallocated
    for neuron_index = 1:(size(network.(layers{layer_index}).weights,1)) %heigth of hidden layer %CHANGED:size(network.hidden_layer,2) 
        activation = activar(network.(layers{layer_index}).weights(neuron_index, :), inputs); %CHANGED: network.hidden_layer(:, neuron_index) 
        trans_act = transfer(activation);
        new_inputs = [new_inputs trans_act];
        network.(layers{layer_index}).output(neuron_index)=trans_act;
    end
    inputs = new_inputs;
    end
end