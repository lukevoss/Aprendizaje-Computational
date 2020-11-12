function outputs = forward_propagate(network, row)   
%row is input for network
    inputs=row;
    %hidden layer
    new_inputs = double.empty;
    for neuron_index = 1:(size(network.hidden_layer,1)) %heigth of hidden layer %CHANGED:size(network.hidden_layer,2) 
        activation = activar(network.hidden_layer(neuron_index, :), inputs); %CHANGED: network.hidden_layer(:, neuron_index) 
        new_inputs = [new_inputs transfer(activation)];
        %TODO output isnt saved in the neuron
    end
    inputs = new_inputs;
    %output layer
    new_inputs = double.empty %CHANGE: outputs = double.empty;
    for neuron_index = 1:(size(network.output_layer,1))
        activation = activar(network.output_layer(neuron_index, :), inputs); %CHANGED: network.output_layer(:, neuron_index) 
        new_inputs = [new_inputs transfer(activation)];
        %TODO output isnt saved in the neuron
    end
    outputs = new_inputs;
end