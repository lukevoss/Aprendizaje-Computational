function network = initialize_network(n_inputs, n_hidden, n_outputs)
%n_inputs is the number of inputs
%n_hidden is the number of neurons in the hidden layer, each with n_inputs+1 weights
%(one for each input + bias)
%n_outputs is the number of outputs, each with n_hidden+1 weights
%(one for each neuron in hidden layer + bias)
%
% Returns array with weights
hidden_layer=rand(n_hidden, n_inputs);
output_layer=rand(n_outputs, n_hidden);
network.hidden_layer = hidden_layer;
network.output_layer = output_layer;
end

